
import UIKit
import AVFoundation
import DropDown

class textSpeech: UIViewController, AVSpeechSynthesizerDelegate  {
    
    @IBOutlet weak var uiViewMenu: UIView!
    @IBOutlet weak var textDataTable: UITableView!
    @IBOutlet weak var selectLanguage: UIButton!
    @IBOutlet weak var dispLangLbl: UILabel!
    
    
    
    let dropDown = DropDown()
    let speechSythesizer = AVSpeechSynthesizer()
    var selectedLangCode : String?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSythesizer.delegate = self
        textDataTable.dataSource = self
        textDataTable.delegate = self
        textDataTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
    }
    
    
    @IBAction func selectLangBtn(_ sender: UIButton) {
        
        dropDownMenu()
        
    }
    
    func dropDownMenu(){
        
        dropDown.dataSource = ["en-US", "es-ES", "fr-FR", "de-DE","hi-IN","zh-CN","ja-JP","ru-RU","th-TH"]
        dropDown.anchorView = uiViewMenu
        dropDown.bottomOffset = CGPoint(x: 0, y: uiViewMenu.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected Item:---- \(item) at index:---- \(index)")
            self.selectedLangCode = item
            
        }
        
        
    }
    
    func speakText(_ text: String){
        
        guard let languageCode = selectedLangCode,
              let voice = AVSpeechSynthesisVoice(language: languageCode) else {
                  print("Voice are not availabel------ \(selectedLangCode ?? "nil")")
                  
                  return
              }
        dispLangLbl.text = "Language Selected \(selectedLangCode ?? "nil")"
        
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = voice
        speechSythesizer.speak(speechUtterance)
        
        
        print("speaking:\(text) in \(languageCode)")
    }
    
    
}


extension textSpeech: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = textDataTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedText = tableData[indexPath.row]
        print("selectedText from table:--- \(selectedText)")
        speakText(selectedText)
        
    }
}
