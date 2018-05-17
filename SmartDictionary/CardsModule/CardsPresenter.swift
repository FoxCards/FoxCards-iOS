//
//  CardsPresenter.swift
//  SmartDictionaty
//
//  Created by Андрей Коноплев on 21.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation


class CardPresenter: CardPresenterInput {

    weak var view: CardViewInput?
    fileprivate var words = [Word]()
    
}

extension CardPresenter {
    func viewDidLoad() {
        
    }
    
    func viewWillAppear(animate: Bool) {
        
    }
    
    func numberOfEntities() -> Int {
        return words.count
    }
    
    func entityAt(index: Int) -> Any? {
        return words[index]
    }
    
    func getWords(isKnow: Bool?) {
        let word = TestManager.getTestWords(isKnow: isKnow)
        self.words.append(contentsOf: word)
    }
    
    func clearArray() {
        self.words.removeAll()
    }
    
    func updateWordToKnown(obj: Word) {
        WordsFabrique.setWord(word: obj.word!, transcription: obj.transcriptions!, translate: obj.translate!, isKnow: true, language: nil, context: CoreDataManager.sharedInstance.getMainContext())
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func updateWordToUnknown(obj: Word) {
        WordsFabrique.setWord(word: obj.word!, transcription: obj.transcriptions!, translate: obj.translate!, isKnow: false, language: nil, context: CoreDataManager.sharedInstance.getMainContext())
        CoreDataManager.sharedInstance.saveContext()
    }
    
}
