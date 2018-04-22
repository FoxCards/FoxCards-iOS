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
        let predicate = NSPredicate(format: "word=%@ AND language=%@", word, const.app_settings.app_language?.name ?? "")
        fetchRequest.predicate = predicate

        let fetchResult = try? context.fetch(fetchRequest) as! [Word]
        return fetchResult?.count == 0 ? nil : fetchResult![0]
    }

    class func setWord(word: String, transcription: String, translate: String, isKnow: Bool, context: NSManagedObjectContext) {
        
        var thisWord = getWord(word: word, context: context)
        if thisWord == nil {
            thisWord = NSEntityDescription.insertNewObject(forEntityName: "Word", into: context) as? Word
            thisWord!.word = word
            thisWord!.transcriptions = transcription
            thisWord!.translate = translate
            thisWord!.isKnow = isKnow
            thisWord!.date = Date()
            thisWord!.language = const.app_settings.app_language?.name ?? ""
        } else {
            thisWord!.transcriptions = transcription
            thisWord!.translate = translate
            thisWord!.isKnow = isKnow
            thisWord!.date = Date()
            thisWord!.language = const.app_settings.app_language?.name ?? ""
        }
    }
}

