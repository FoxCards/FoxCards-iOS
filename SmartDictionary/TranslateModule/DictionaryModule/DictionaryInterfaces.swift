//
//  DictionaryInterfaces.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation


protocol DictionaryViewInput: class {
    func reloadData()
}

protocol DictionaryViewOutput: class {
    
}

protocol DictionaryPresenterInput: class {
    func viewDidLoad()
    func viewWillAppear(animate: Bool)
    func numberOfEntities(segmentState: Int)-> Int
    func entityAt(index: IndexPath, segmentState: Int)-> Any?
}

protocol DictionaryFrcViewChange: class {
    func beginUpdates()
    func endUpdates()
    func insert(to newIndexPath: IndexPath?)
    func update(indexPath: IndexPath?, object: Word)
    func move(from indexPath: IndexPath?, to newIndexPath: IndexPath?)
    func delete(indexPath: IndexPath?)
}

protocol  DictionaryPresenterOutput: class{
    
}
