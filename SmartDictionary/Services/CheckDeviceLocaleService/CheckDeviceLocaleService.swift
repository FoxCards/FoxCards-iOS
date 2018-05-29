//
//  CheckDeviceLocaleService.swift
//  Foxcards
//
//  Created by Андрей Коноплев on 24.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import UIKit

class CheckDeviceLocaleService {
    //get locale
    class func getDeviceLocale()-> String {
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            return countryCode
        } else {
            return "locale undefind"
        }
    }
    
    //iphone or ipad
    class func getDevice() -> String {
        return UIDevice.current.model
    }
    
    // iOS version
    class func getIOSVersion()-> String {
        return UIDevice.current.systemVersion
    }
    
    // device model
    class func getDeviceMoodel()-> String {
        var system = utsname()
        uname(&system)
        let machineMirror = Mirror(reflecting: system.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    //send locale to server
       class func sendLocale() {
        let locale = CheckDeviceLocaleService.getDeviceLocale()
        let device = CheckDeviceLocaleService.getDevice()
        let iOSVersion = CheckDeviceLocaleService.getIOSVersion()
        let deviceModel = CheckDeviceLocaleService.getDeviceMoodel()
        _ = API_wrapper.firstIn(locale: locale, device: device, iOS: iOSVersion, deviceModel: deviceModel, success: { (response) in
            print(response)
        }, failure: { (error) in
            print(error)
        })
    }
}
