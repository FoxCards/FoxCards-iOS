//
//  EditingPresenter.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 27.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import CoreData

class EditingPresenter:  EditingPresenterOutput, EditingPresenterInput {
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear(animate: Bool) {
        
    }
    
    
    weak var view: EditingViewInput?
    
    func save(word: String, transcription: String, translate: String, isKnown: Bool) {
        WordsFabrique.setWord(word: word, transcription: transcription, translate: translate, isKnow: isKnown, context: CoreDataManager.sharedInstance.getMainContext())
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func translate(text: String) -> String {
        return ""
    }
}
