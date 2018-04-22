//
//  LanguageModel.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class LanguageModel {
    let name: String
    let api_locale: String
    let speach_locale: String
    let imgLang: String
    
    
    
    init(name: String, api_locale: String, speach_locale: String, imgLang: String) {
        self.name = name
        self.api_locale = api_locale
        self.speach_locale = speach_locale
        self.imgLang = imgLang
    }
    
    func reverseApiLocale()-> String {
        let second_locale = api_locale.index(api_locale.endIndex, offsetBy: -3)..<api_locale.endIndex
        var y = api_locale
        y.removeSubrange(second_locale)
        let reverseApiLocale = "ru-" + y
        return reverseApiLocale
    }
}
