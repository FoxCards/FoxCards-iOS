//
//  CollectionsCardSetsOperation.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 14.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import SwiftyJSON


class CollectionCardSetsOperation: Operation {
    
    var success: ([CardCollectionModel]) -> Void
    
    required init(success: @escaping ([CardCollectionModel])-> Void) {
        self.success = success
    }
    override func main() {
        _ = API_wrapper.getAllCardSet(success: { (response) in
            //arrayWith cardCollection
            var arrayCollections = [CardCollectionModel]()
            let json = JSON(response)
            let arrayObj = json[].arrayValue
            
            for obj in arrayObj {
                //array with cardSets
                var arraySets = [CardSetModel]()
                
                let id = obj["id"].intValue
                let lang = obj["name"].stringValue
                let locale = obj["locale"].stringValue
                let cardsets = obj["cardsets"].arrayValue
                if cardsets.count > 0 {
                    for card in cardsets {
                        
                        
                        let id = card["id"].intValue
                        let name = card["name"].stringValue
                        let word_count = card["words_count"].intValue
                        let image = card["cover_url"].stringValue
                        arraySets.append(CardSetModel(id: id, name: name, img: image, locale: locale, word_count: word_count))
                    }
                }
                
                let collectionModel = CardCollectionModel(id: id, locale: locale, lang: lang, cardCollection: arraySets)
                
                arrayCollections.append(collectionModel)
            }
            
            self.success(arrayCollections)
        }, failure: { (error) in
            print(error)
        })
    }
}
