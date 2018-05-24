//
//  CurrentLanguageFabrique.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 05.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import CoreData

class CurrentLanguageFabrique {
    let context = CoreDataManager.sharedInstance.getMainContext()
    class func getCurrentLang(context: NSManagedObjectContext) -> Current_lang? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Current_lang")
        let predicate = NSPredicate(format: "id=%lld", 1)
        fetchRequest.predicate = predicate
        
        let fetchResult = try? context.fetch(fetchRequest) as! [Current_lang]
        return fetchResult!.count == 0 ? nil : fetchResult![0]
    }
    
    class func updateCurrentLang(name: String, api_locale: String, speach_locale: String, lang_image: String, context: NSManagedObjectContext ) {
        
        let current_lang = self.getCurrentLang(context: context)
        if current_lang == nil {
            let lang = NSEntityDescription.insertNewObject(forEntityName: "Current_lang", into: context) as! Current_lang
            lang.id = 1
            lang.api_locale = api_locale
            lang.name = name
            lang.lang_image = lang_image
            lang.speach_locale = speach_locale
        } else {
            current_lang!.api_locale = api_locale
            current_lang!.name = name
            current_lang!.speach_locale = speach_locale
            current_lang!.lang_image = lang_image
        }
        CoreDataManager.sharedInstance.saveContext()
    }
}
