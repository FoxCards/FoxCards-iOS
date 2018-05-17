//
//  WordsFabrique.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import CoreData

class WordsFabrique {
    class func getWord(word: String, context: NSManagedObjectContext )-> Word? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
        let predicate = NSPredicate(format: "word=%@ AND language=%@", word, const.app_settings.app_language?.speach_locale ?? "")
        fetchRequest.predicate = predicate

        let fetchResult = try? context.fetch(fetchRequest) as! [Word]
        return fetchResult?.count == 0 ? nil : fetchResult![0]
    }

    class func setWord(word: String, transcription: String, translate: String, isKnow: Bool,language: String? , context: NSManagedObjectContext) {
        
        var thisWord = getWord(word: word, context: context)
        if thisWord == nil {
            thisWord = NSEntityDescription.insertNewObject(forEntityName: "Word", into: context) as? Word
            thisWord!.word = word
            thisWord!.transcriptions = transcription
            thisWord!.translate = translate
            thisWord!.isKnow = isKnow
            thisWord!.date = Date()
            if language == nil {
                thisWord!.language = const.app_settings.app_language?.speach_locale ?? ""
            } else {
                thisWord?.language = language
            }
            
        } else {
            thisWord!.transcriptions = transcription
            thisWord!.translate = translate
            thisWord!.isKnow = isKnow
            thisWord!.date = Date()
            if language == nil {
                thisWord!.language = const.app_settings.app_language?.speach_locale ?? ""
            } else {
                thisWord?.language = language
            }
        }
    }
}

