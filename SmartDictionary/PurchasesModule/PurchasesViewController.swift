//
//  PurchasesViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 15.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol PurchasesViewInput {
    var dataSource: [CardCollectionModel] { get set }
    func reloadData()
}

class PurchasesViewController: UIViewController, PurchasesViewInput {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: PurchasesPresenter?
    var dataSource = [CardCollectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PurchasesPresenter(view: self)
        registerNib()
        //SVProgressHUD.show()
        //presenter?.getAllCards()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension PurchasesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5 //dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "test" //dataSource[section].lang
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "purchasesCell", for: indexPath) as! PurchasesTableViewCell
        //cell.configure(dataSource: dataSource[indexPath.section].cardSets, vc: self)
        cell.configure(vc: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? PurchasesTableViewCell)?.reloadData()
    }
}

extension PurchasesViewController {
    func registerNib() {
        let nib = UINib(nibName: "PurchasesTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "purchasesCell")
    }
}

