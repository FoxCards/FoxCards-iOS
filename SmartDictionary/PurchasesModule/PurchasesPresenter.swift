//
//  PurchasesPresenter.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 15.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol PurchasesPresenterProtocol: class {
    func getAllCards() -> Void
}
class PurchasesPresenter: PurchasesPresenterProtocol {
    
    var view: PurchasesViewInput?
    
    required init(view: PurchasesViewController) {
        self.view = view
    }
    
    func getAllCards() {
        DataProvider.getAllCardSets { (array) in
            DispatchQueue.main.async {
                self.view?.dataSource = array
                self.view?.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
}
