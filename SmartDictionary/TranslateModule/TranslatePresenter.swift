//
//  TranslatePresenter.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 02.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation


class TranslatePresenter: TranslatePresenterInput {
    
    weak var view: TranslateViewInput?
    
    func viewDidLoad() {
    }
    
    func viewWillAppear(animate: Bool) {
    }
    
    func save(word: String, transcription: String, translate: String, isKnown: Bool) {
        WordsFabrique.setWord(word: word, transcription: transcription, translate: translate, isKnow: isKnown, language: nil, context: CoreDataManager.sharedInstance.getMainContext())
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func translate(text: String) -> String {
        return ""
    }
}
