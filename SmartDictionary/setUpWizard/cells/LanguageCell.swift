//
//  LanguageCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class LanguageCell: UITableViewCell {

    @IBOutlet weak var langImage: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(LanguageModel: LanguageModel) {
        self.languageLabel.text = LanguageModel.name
        self.langImage.image = UIImage(named: LanguageModel.speach_locale)
        
    }
    
}
