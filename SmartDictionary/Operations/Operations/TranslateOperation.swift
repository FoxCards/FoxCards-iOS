//
//  TranslateOperation.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import SwiftyJSON
import RNCryptor

class TranslateOperation: Operation {
    var text = ""
    var locale = ""
    var success: (_ translate: String)-> Void
    var failure: (_ error: String)-> Void
    
    
    
    required init(text: String, locale: String, success: @escaping (_ translate: String)-> Void, failure: @escaping (_ error: String)-> Void) {
        self.text = text
        self.success = success
        self.failure = failure
        self.locale = locale
    }
    
    override func main() {
        
        let semaphore = DispatchSemaphore(value: 0)
        let data: Data = self.text.data(using: .utf8)!
        let ciphertext = RNCryptor.encrypt(data: data, withPassword: const.API_statements.salt)
        print(ciphertext.base64EncodedString(options: .init(rawValue: 0)))
        _ = API_wrapper.getTranslate(text: ciphertext.base64EncodedString(options: .init(rawValue: 0)), locale: locale, success: { (response) in
            let json = JSON(response)
//            print(json)
//            let id = json["id"].stringValue
//            let lang = json["langs"].stringValue
            let translate = json["translation"].stringValue
            self.success(translate)
            semaphore.signal()
           
        }) { (error) in
            print(error)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
