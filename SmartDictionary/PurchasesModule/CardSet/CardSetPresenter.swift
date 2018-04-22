//
//  CardSetPresenter.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 16.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

protocol CardSetPresenterProtocol: class {
    func getCardSet(id: Int) -> Void
}

class CardSetPresenter: CardSetPresenterProtocol {
    func getCardSet(id: Int) {
        
    }
    
    
    weak var view: CardSetViewInput?
    
    required init(view: CardSetViewInput) {
        self.view = view
    }
    
    func getCardSet() {
        
    }
}
