//
//  CheckDeviceLocaleService.swift
//  Foxcards
//
//  Created by Андрей Коноплев on 24.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class CheckDeviceLocaleService {
    //get locale
    class func getDeviceLocale()-> String {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            return countryCode
        } else {
            return "locale undefind"
        }
    }
    
    //send locale to server
    class func sendLocale() {
        let locale = CheckDeviceLocaleService.getDeviceLocale()
        _ = API_wrapper.firstIn(locale: locale, success: { (response) in
            print(response)
        }, failure: { (error) in
            print(error)
        })
    }
}
