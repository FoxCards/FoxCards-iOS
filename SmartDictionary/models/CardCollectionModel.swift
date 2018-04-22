//
//  CardsCollectionModel.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 15.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class CardCollectionModel {
    let id: Int
    let lang: String
    let locale: String
    let cardSets: [CardSetModel]
    
    init(id: Int, locale: String, lang: String, cardCollection: [CardSetModel]) {
        self.id = id
        self.locale = locale
        self.lang = lang
        self.cardSets = cardCollection
    }
}
