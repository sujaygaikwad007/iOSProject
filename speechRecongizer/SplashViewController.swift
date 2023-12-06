import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("insplashScreen---")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let controlVC = self.storyboard?.instantiateViewController(withIdentifier: "startViewController") as! startViewController
            self.navigationController?.pushViewController(controlVC, animated: true)
        }
    }
        
       
    
   
}
