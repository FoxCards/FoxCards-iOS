//
//  constant.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 21.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

struct const {
    struct API_statements {
        static let base_url = "http://188.225.11.241"
        static let salt = ""
    }
    
    struct app_settings {
        static var app_language = CurrentLanguageFabrique.getCurrentLang(context: CoreDataManager.sharedInstance.getMainContext())
    }
    
    struct languages {
        static let english = LanguageModel(name: "Английский", api_locale: "en-ru", speach_locale: "en_US", imgLang: "english.jpg")
        static let spain = LanguageModel(name: "Испанский", api_locale: "es-ru", speach_locale: "es-ES", imgLang: "spain.jpg")
        static let italy = LanguageModel(name: "Итальянский", api_locale: "it-ru", speach_locale: "it-IT", imgLang: "italy.jpg")
        static let germany = LanguageModel(name: "Немецкий", api_locale: "de-ru", speach_locale: "de-DE", imgLang: "germany.jpg")
        static let france = LanguageModel(name: "Французский", api_locale: "fr-ru" , speach_locale: "fr-FR", imgLang: "france.jpg")
        
        static let langArray: [LanguageModel] = [english, spain, italy, germany, france]
    }
}
