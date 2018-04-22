//
//  +extensionViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 03.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setUpBackgroundImage(imageName: String) {
        let backgroundImage = UIImage.init(named: imageName)
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.6
        
        if self.view.subviews.first as? UIImageView == nil {
            self.view.insertSubview(backgroundImageView, at: 0)
        } else{
            self.view.subviews.first?.removeFromSuperview()
            self.view.insertSubview(backgroundImageView, at: 0)
        }
        
    }
}
