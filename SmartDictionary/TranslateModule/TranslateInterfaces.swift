//
//  TranslateInterfaces.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 02.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

protocol TranslateViewInput: class {
    func reloadData()
}

protocol TranslateViewOutput: class {

}

protocol TranslatePresenterInput: class {
    func viewDidLoad()
    func viewWillAppear(animate: Bool)
    func save(word: String, transcription: String, translate: String, isKnown: Bool)
    func translate(text: String)-> String
    
}

protocol  TranslatePresenterOutput: class{
    
}
