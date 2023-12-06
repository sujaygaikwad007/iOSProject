
import UIKit
import InstantSearchVoiceOverlay
import Speech

class startViewController : UIViewController {
    
    var voiceOverlay = VoiceOverlayController()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var micImage: UIImageView!
    @IBOutlet weak var textSpeechBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackground()
        myButton.layer.cornerRadius = 20.0
        textSpeechBtn.layer.cornerRadius = 20.0
        
        
    }
    
    @IBAction func openMicBtn(_ sender: UIButton) {
        
        let speechVC = storyboard?.instantiateViewController(withIdentifier: "speechRecongizer") as! speechRecongizer
        self.navigationController?.pushViewController(speechVC, animated: true)
        
        
    }
    
    
    @IBAction func textSpeechBtn(_ sender: UIButton) {
        
        let textToSpeechVC = storyboard?.instantiateViewController(withIdentifier: "textSpeech") as! textSpeech
        self.navigationController?.pushViewController(textToSpeechVC, animated: true)
        
    }
    
    func addGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = mainView.bounds
        gradientLayer.colors = [UIColor.systemMint.cgColor, UIColor.systemTeal.cgColor]
        gradientLayer.locations = [0.3, 1.0]
        mainView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    /*  func OpenMic(){
     voiceOverlay.start(on: self, textHandler: { text, final, _ in
     
     if final {
     print("Final text: \(text)")
     }
     else {
     print("In progess: \(text)")
     }
     
     }, errorHandler: { error in
     
     })
     } */
    
    
    
    
    
    
    
}

