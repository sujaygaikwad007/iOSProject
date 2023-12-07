//
//  TextSpeechTVC.swift
//  speechRecongizer
//
//  Created by Aniket Patil on 06/12/23.
//

import UIKit



class TextSpeechTVC: UITableViewCell {
    
    @IBOutlet weak var lblSpeech: UILabel!
    @IBOutlet weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

      mainView.layer.cornerRadius = 20.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
