

import UIKit
import Speech
import WebKit

class speechRecongizer: UIViewController, SFSpeechRecognizerDelegate , WKNavigationDelegate {
    
    
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var startStopBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    
    
    
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startStopBtn.isEnabled = false
        speechRecognizer.delegate = self
        webView.navigationDelegate = self
        
        // Request speech recognition authorization

        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                if authStatus == .authorized {
                    self.startStopBtn.isEnabled = true
                }
            }
        }

    }

    @IBAction func startStopBtn(_ sender: UIButton) {
        
        if audioEngine.isRunning {
            print("stop button clicked------")
            audioEngine.stop()
            recognitionRequest?.endAudio()
            startStopBtn.isEnabled = false
            startStopBtn.setTitle("Start Recording", for: .normal)
           

        } else {
            startRecording()
            startStopBtn.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func startRecording(){
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(.record, mode: .default, options: [])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session error: ---------\(error)")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
         var isFinal = false
            
            if let result = result  {
                self.searchTextField.text = ""
               self.searchTextField.text = result.bestTranscription.formattedString
                print("Result of voice--------\(result.bestTranscription.formattedString)")
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.startStopBtn.isEnabled = true
            }
        
    }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audio engine error: \(error)")
        }
    
        searchTextField.text = "Say something, I'm listening"
}
    
    
    
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        
        if let seacrhText = searchTextField.text, !seacrhText.isEmpty
        {
            let query = seacrhText.replacingOccurrences(of: " ", with: "+")
            print("Query From TextField--------\(query)")
            let searchUrlString = "https://www.google.com/search?q=\(query)"
            if let searchUrl = URL(string: searchUrlString)
            {
                let request = URLRequest(url: searchUrl)
                webView.load(request)
            }
        }
        else{
            showToast(controller: self, message: "TextField should not be empty", seconds: 2)
        }
        
        
        
    }
    
    
    //Function for alert message
    
    func showToast(controller:UIViewController ,message:String,seconds:Double)
    {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        let CancelBtn = UIAlertAction(title: "Close", style: .destructive)
        alert.addAction(CancelBtn)
        
        controller.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + seconds)
        {
            alert.dismiss(animated: true)
        }
    }
    
    
    
    
    
}


