//
//  +extensionCurrentLangModel.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 06.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation


extension Current_lang {
    func reverseApiLocale()-> String {
        if let api_locale = api_locale {
            let second_locale = api_locale.index(api_locale.endIndex, offsetBy: -3)..<api_locale.endIndex
            var y = api_locale
            y.removeSubrange(second_locale)
            let reverseApiLocale = "ru-" + y
            return reverseApiLocale
        } else {
            return ""
        }

    }
}
