//
//  SaveWordService.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class SaveWordService {
    let context = CoreDataManager.sharedInstance.getMainContext()
    
    func saveWords(words: [WordModel], success: ()-> Void) {
        for word in words {
            WordsFabrique.setWord(word: word.word, transcription: word.transcription, translate: word.translate, isKnow: false, language: word.language, context: self.context)
        }
        _ = try? context.save()
        success()
    }
}
