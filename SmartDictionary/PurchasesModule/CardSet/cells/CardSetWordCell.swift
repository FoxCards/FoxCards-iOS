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
    
    @IBOutlet weak var widthConstraint2: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint1: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
        widthConstraint1.constant = (UIScreen.main.bounds.width / 2) - 20
        widthConstraint2.constant = (UIScreen.main.bounds.width / 2) - 20
        layoutIfNeeded()
        
    }


    func configure(word: String, translate: String) {
        self.wordLabel.text = word
        self.translateLabel.text = translate
    }
    
}
