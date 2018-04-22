//
//  CardsInterfaces.swift
//  SmartDictionaty
//
//  Created by Андрей Коноплев on 21.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

protocol CardViewInput: class {
    func reloadData()
}

protocol CardViewOutput: class {
    
}

protocol CardPresenterInput: class {
    func viewDidLoad()
    func viewWillAppear(animate: Bool)
    func numberOfEntities()-> Int
    func entityAt(index: Int)-> Any?
}

protocol  CardPresenterOutput: class{
    
}
