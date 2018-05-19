//
//  CardSetViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 08.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import SVProgressHUD
protocol CardSetViewInput: class {
    var id: Int? { get set }
    var thisSet: CardSetModel? { get set }
    func reloadData()
}

class CardSetViewController: UIViewController, CardSetViewInput {
    var thisSet : CardSetModel?
    var selectWord = [Int : WordModel]()
    var id: Int?
    
    var saveWordService = SaveWordService()
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var tableVIew: UITableView!
    
    func reloadData() {
        self.tableVIew.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        self.tableVIew.tableFooterView = UIView()
        addButton.isHidden = true
        _ = DataProvider.getCardSet(by: self.id ?? 1, success: { (response) in
            DispatchQueue.main.async {
                self.thisSet = response
                self.tableVIew.tableHeaderView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), model: self.thisSet!, vc: self)
                self.navigationItem.title = self.thisSet?.name
                self.tableVIew.reloadData()
                SVProgressHUD.dismiss()
            }
        })
        
        self.tableVIew.contentInset = UIEdgeInsetsMake(-64,0,0,0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SVProgressHUD.dismiss()
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
}

extension CardSetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisSet?.words?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "carSetWordCell", for: indexPath) as! CardSetWordCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? CardSetWordCell
        cell?.configure(word: thisSet?.words?[indexPath.row].word ?? "", translate: thisSet?.words?[indexPath.row].translate ?? "")
        cell?.selectedBackgroundView = UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = thisSet?.words![indexPath.row]
        self.selectWord[indexPath.row] = word
        addButton.setTitle("Добавить слов в словарь: \(selectWord.count)", for: .normal)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectWord.removeValue(forKey: indexPath.row)
        addButton.setTitle("Добавить слов в словарь: \(selectWord.count)", for: .normal)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 3)!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = (scrollView.contentOffset.y - 100) / 150
        if offset > 1 {
            offset = 1
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset , brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.red]
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        } else {
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
        }
    }

}

extension CardSetViewController {
    @IBAction func pushToSelect(_ sender: Any) {
        if !self.tableVIew.isEditing {
            self.tableVIew.setEditing(true, animated: true)
            selectWord.removeAll()
            selectButton.title = "Отменить"
            addButton.isHidden = false
            tableViewBottomConstraint.constant = 40
            self.tableVIew.allowsMultipleSelection = true
        } else {
            self.tableVIew.setEditing(false, animated: true)
            self.selectWord.removeAll()
            selectButton.title = "Выбор"
            addButton.isHidden = true
            tableViewBottomConstraint.constant = 0
            addButton.setTitle("Добавить слов в словарь: \(selectWord.count)", for: .normal)
            self.tableVIew.allowsSelection = false
        }
    }
    
    @IBAction func saveWord(_ sender: Any) {
        var selectWordsModels = [WordModel]()
        for (key,value) in self.selectWord {
            selectWordsModels.append(value)
            _ = key
        }
        self.saveWordService.saveWords(words: selectWordsModels, success: {
            SVProgressHUD.showSuccess(withStatus: "Сохранено в ваш словарь")
        })
        self.selectWord.removeAll()
        addButton.setTitle("Добавить слов в словарь: \(selectWord.count)", for: .normal)
        selectButton.title = "Выбор"
        self.addButton.isHidden = true
        tableViewBottomConstraint.constant = 0
        self.tableVIew.setEditing(false, animated: true)
        self.tableVIew.allowsMultipleSelection = false
    }
}

extension CardSetViewController {
    func registerNib() {
        let nib = UINib(nibName: "CardSetWordCell", bundle: nil)
        self.tableVIew.register(nib, forCellReuseIdentifier: "carSetWordCell")
    }
    
    //nav bar transition
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setColors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
    }
    
    private func animate() {
        guard let coordinator = self.transitionCoordinator else {
            return
        }
        coordinator.animate(alongsideTransition: {
            [weak self] context in
            self?.setColors()
            self?.navigationItem.title = self?.thisSet?.name
            }, completion: nil)
    }
    
    private func setColors(){
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }

}

