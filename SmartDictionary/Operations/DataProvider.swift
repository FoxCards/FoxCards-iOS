//
//  DataProvider.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class DataProvider {
    class func getTranslate(text: String, locale: String, success: @escaping (_ translate: String)-> Void, failure: @escaping (_ error: String)-> Void) {
        let operation = TranslateOperation(text: text, locale: locale, success: success, failure: failure)
        OperationsManager.addOperation(op: operation, cancelFlag: true)
    }
    
    class func getAllCardSets(success: @escaping ([CardCollectionModel])-> Void) {
        let operation = CollectionCardSetsOperation(success: success)
        OperationsManager.addOperation(op: operation, cancelFlag: true)
    }
    
    class func getCardSet(by id: Int, success: @escaping (CardSetModel)-> Void) {
        let operation = CardSetOperation(id: id, success: success)
        OperationsManager.addOperation(op: operation, cancelFlag: true)
    }
}
