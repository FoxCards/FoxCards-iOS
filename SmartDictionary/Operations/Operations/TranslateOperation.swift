//
//  TranslateOperation.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import SwiftyJSON


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
        _ = API_wrapper.getTranslate(text: text, locale: locale, success: { (response) in
            let json = JSON(response)
            let dict = json.dictionaryValue
            if dict["text"]?[] == nil {
                semaphore.signal()
                return
            } else {
                let array = dict["text"]![]
                let translate = array[0].stringValue
                self.success(translate)
                semaphore.signal()
            }
           
        }) { (error) in
            print(error)
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
