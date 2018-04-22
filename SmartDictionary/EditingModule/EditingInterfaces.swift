//
//  EditingInterfaces.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 27.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation


protocol EditingViewInput: class {
    func reloadData()
}

protocol EditingPresenterOutput: class {
    func save(word: String, transcription: String, translate: String, isKnown: Bool)
    func translate(text: String)-> String
}

protocol EditingPresenterInput: class {
    func viewDidLoad()
    func viewWillAppear(animate: Bool)
    
}


