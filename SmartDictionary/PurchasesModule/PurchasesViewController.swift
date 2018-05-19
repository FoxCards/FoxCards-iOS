//
//  PurchasesViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 15.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import SVProgressHUD
import AudioToolbox

protocol PurchasesViewInput {
    var id: Int? { get set }
    var dataSource: [CardCollectionModel] { get set }
    func reloadData()-> Void
    func endRefresh()-> Void
}

class PurchasesViewController: UIViewController, PurchasesViewInput {

    @IBOutlet weak var tableView: UITableView!
    var id: Int?
    var presenter: PurchasesPresenter?
    let refreshControl = UIRefreshControl()
    var dataSource = [CardCollectionModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = PurchasesPresenter(view: self)
        registerNib()
        SVProgressHUD.show()
        presenter?.getAllCards()
        setUpRefresh()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension PurchasesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].lang
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "purchasesCell", for: indexPath) as! PurchasesTableViewCell
        cell.configure(dataSource: dataSource[indexPath.section].cardSets, vc: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? PurchasesTableViewCell
        cell?.configure(dataSource: dataSource[indexPath.section].cardSets, vc: self)
        (cell)?.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension PurchasesViewController {
    func registerNib() {
        let nib = UINib(nibName: "PurchasesTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "purchasesCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "cardsToCard", let dest = segue.destination as? CardSetViewController {
            dest.id = self.id
        }
    }
    
    //refreshControll
    func setUpRefresh() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.tintColor = UIColor.gray
        self.refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        tableView.sendSubview(toBack: refreshControl)
    }
    
    @objc func update() {
        self.presenter?.getAllCards()
        AudioServicesPlaySystemSound(1519)
    }
    
    func endRefresh() {
        self.refreshControl.endRefreshing()
    }
}

