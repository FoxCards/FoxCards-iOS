//
//  CardSetsCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 08.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class CardSetsCell: UICollectionViewCell {

    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(flagImg: String, model: CardSetModel? ) {
        guard let model = model else { return }
        self.flagImg.image = UIImage(named: "\(flagImg)")
        self.mainImg.kf.setImage(with: URL(string: model.img))
        textLabel.text = model.name
    }

}
