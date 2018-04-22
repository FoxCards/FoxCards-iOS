//
//  File.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 27.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import CoreData


class TestManager {
    var context = CoreDataManager.sharedInstance.getMainContext()
    
    class func getTestWords(isKnow: Bool?)-> [Word] {
        let context = CoreDataManager.sharedInstance.getMainContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
        var predicate: NSPredicate?
        if isKnow != nil {
             predicate = NSPredicate(format: "isKnow=%i AND language=%@", isKnow! as CVarArg, const.app_settings.app_language?.name ?? "" )
            fetchRequest.predicate = predicate
        }
        
        let fetchResult = try? context.fetch(fetchRequest) as! [Word]
        
        return fetchResult!
        
    }
}
