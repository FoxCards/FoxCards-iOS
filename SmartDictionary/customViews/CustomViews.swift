//
//  CustomViews.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 02.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class SaveButtonStyle: UIButton {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setStyle()
    }
    
    private func setStyle() {
        layer.cornerRadius = 15
        layer.borderWidth = 0
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    override var isEnabled: Bool {
        didSet{
            self.alpha = isEnabled ? 1 : 0.5
        }
        
    }
}
