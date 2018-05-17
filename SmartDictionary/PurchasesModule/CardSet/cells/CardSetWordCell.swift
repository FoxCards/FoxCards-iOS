//
//  CardSetWordCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 14.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class CardSetWordCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func configure(word: String, translate: String) {
        self.wordLabel.text = word
        self.translateLabel.text = translate
    }
    
}
