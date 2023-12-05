
import UIKit
import AVFoundation

class textSpeech: UIViewController, AVSpeechSynthesizerDelegate  {

    @IBOutlet weak var languagePicker: UIPickerView!
    @IBOutlet weak var textDataTable: UITableView!
    
    @IBOutlet weak var selectLanguage: UIButton!
    
    let speechSythesizer = AVSpeechSynthesizer()
    
    let language = ["en-US", "es-ES", "fr-FR", "de-DE","hi-IN","zh-CN","ja-JP","ru-RU","th-TH"]
    
    
    
    let tableData = ["I'm not really a TV watcher.",
                     "I'm not a big fan of snacking.",
                     "George works on a small farm.",
                     "I don’t like tea.",
                     "It's so hot.","Thank you"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSythesizer.delegate = self
        languagePicker.delegate = self
        languagePicker.dataSource = self
        textDataTable.dataSource = self
        textDataTable.delegate = self
        
        languagePicker.isHidden = true
        
        textDataTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")


     
    }
    
    
    @IBAction func selectLangBtn(_ sender: UIButton) {
        
        languagePicker.isHidden = false
        
        
    }
    
    func speakText(_ text: String, languageCode: String){
        
        guard let voice = AVSpeechSynthesisVoice(language: languageCode) else {
            print("Voice are not availabel------ \(languageCode)")
            return
        }
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = voice
        speechSythesizer.speak(speechUtterance)
        
        
        print("speaking:\(text) in \(languageCode)")
    }
    

}


extension textSpeech: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return language[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      let  selectedValue = language[row]
        
            
        
        print("slected value:-----\(selectedValue)")
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
        let selectedLanguageIndex = languagePicker.selectedRow(inComponent: 0)
        print("selectedLanguageIndex:----- \(selectedLanguageIndex)")
        let selectedLanguageCode = language[selectedLanguageIndex]
        speakText(selectedText, languageCode: selectedLanguageCode)
        
    }
}
