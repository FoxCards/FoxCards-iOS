//
//  CardSetModel.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 14.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class CardSetModel {
    let id: Int
    let name: String
    let img: String
    let word_count: Int
    let locale: String
    var words: [WordModel]?
    
    init(id: Int, name: String, img: String, locale: String, word_count: Int) {
        self.id = id
        self.name = name
        self.img = img
        self.word_count = word_count
        self.locale = locale
    }
    
    func setWord(words: [WordModel]) {
        self.words = words
    }
}
