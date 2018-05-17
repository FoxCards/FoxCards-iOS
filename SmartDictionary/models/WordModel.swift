//
//  WordModel.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 15.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class WordModel {
    
    let word: String
    let transcription: String
    let translate: String
    let language: String
    
    init(word: String, transcription: String, translate: String, language: String) {
        self.word = word
        self.transcription = transcription
        self.translate = translate
        self.language = language
    }
}
