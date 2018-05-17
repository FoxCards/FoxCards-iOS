//
//  +extensionStoryboard.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 13.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import UIKit



enum Storyboards: String {
    case main = "Main"
}
    
extension UIStoryboard {
    static func create(_ storyboard: Storyboards) -> UIStoryboard {
        return UIStoryboard.init(name: storyboard.rawValue, bundle: nil)
    }
}
        
        

