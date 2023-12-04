
import UIKit
import InstantSearchVoiceOverlay
import Speech

class ViewController: UIViewController {
    
    var voiceOverlay = VoiceOverlayController()
    
    
    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var micImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func openMicBtn(_ sender: UIButton) {
        
        let speechVC = storyboard?.instantiateViewController(withIdentifier: "speechRecongizer") as! speechRecongizer
        self.navigationController?.pushViewController(speechVC, animated: true)
        

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

