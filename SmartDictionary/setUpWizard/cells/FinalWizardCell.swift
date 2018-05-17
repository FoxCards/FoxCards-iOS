//
//  FinalWizardCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class FinalWizardCell: UICollectionViewCell {
    
    var vc: SetUpWizardVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configure(vc: SetUpWizardVC) {
        self.vc = vc
    }

    @IBAction func start(_ sender: Any) {
        if const.app_settings.app_language != nil {
            let mainVC = UIStoryboard.create(.main).instantiateViewController(withIdentifier: "mainTabBar")
            self.vc?.present(mainVC , animated: false, completion: nil)
        }
    }
}
