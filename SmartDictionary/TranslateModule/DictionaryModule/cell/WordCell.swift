//
//  WordCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 15.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configure(model: Word) {
        wordLabel.text = model.word
        categoryImage.image = UIImage(named: "\(String(describing: const.app_settings.app_language?.speach_locale ?? "" )).png")
    }


    
}
