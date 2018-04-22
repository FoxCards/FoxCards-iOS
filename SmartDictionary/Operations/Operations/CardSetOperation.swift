//
//  CardSetOperation.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 14.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import SwiftyJSON


class CardSetOperation: Operation {
    let id: Int
    let success: (CardSetModel)-> Void
    
    required init(id: Int, success: @escaping (CardSetModel)-> Void) {
        self.id = id
        self.success = success
    }
    override func main() {
        _ = API_wrapper.getCardSet(id: self.id, success: { (response) in
            let json = JSON(response)
            var wordsArray = [WordModel]()
            
            let id = json["id"].intValue
            let img = json["cover_url"].stringValue
            let name = json["name"].stringValue
            let locale = json["locale"].stringValue
            let words_count = json["words_count"].intValue
            let words = json["words"].arrayValue
        
            let cardSet = CardSetModel(id: id, name: name, img: img, locale: locale, word_count: words_count)
            
            for word in words {
                let thisWord = word["word"].stringValue
                let translation = word["translation"].stringValue
                let transcription = word["transcription"].stringValue
                let objWord = WordModel(word: thisWord, transcription: transcription, translate: translation, language: locale)
                wordsArray.append(objWord)
            }
            
            cardSet.setWord(words: wordsArray)
            self.success(cardSet)
            
        }, failure: { (error) in
            print(error)
        })
    }
}
