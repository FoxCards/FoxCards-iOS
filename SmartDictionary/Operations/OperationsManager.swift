//
//  OperationManager.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation

class OperationsManager {
    private static let operationQueue = OperationQueue()
    
    static func addOperation(op: Operation, cancelFlag: Bool) {
        operationQueue.maxConcurrentOperationCount = 1
        
        if cancelFlag {
            operationQueue.cancelAllOperations()
        }
        operationQueue.addOperation(op)
    }
}
