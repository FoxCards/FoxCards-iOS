//
//  DictionaryViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 21.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class DictionaryViewController: UIViewController, DictionaryViewInput {

    @IBOutlet weak var segmetController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let presenter = DictionaryPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "WordCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "wordCell")
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        segmetController.selectedSegmentIndex = 0
        presenter.viewDidLoad()
        presenter.viewFrc = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Всего слов: \(presenter.numberOfEntities(segmentState: segmetController.selectedSegmentIndex)) "
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfEntities(segmentState: segmetController.selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordCell
        let word = presenter.entityAt(index: indexPath, segmentState: segmetController.selectedSegmentIndex) as! Word
        cell.configure(model: word)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectedWordIndex = indexPath.row
        performSegue(withIdentifier: "addWordSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
            self.presenter.deleteObj(index: indexPath)
        }
        var known = UITableViewRowAction()
        if segmetController.selectedSegmentIndex == 0 {
            known = UITableViewRowAction(style: .default, title: "В изучено") { (action, indexPath) in
                self.presenter.shiftObj(index: indexPath, known: true)
            }
        } else {
            known = UITableViewRowAction(style: .default, title: "Забыл", handler: { (action, indexPath) in
                self.presenter.shiftObj(index: indexPath, known: false)
            })
        }
        known.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        return [delete,known]
    }
}

extension DictionaryViewController: DictionaryFrcViewChange {
    func beginUpdates() {
        tableView.beginUpdates()
    }
    
    func endUpdates() {
        tableView.endUpdates()
    }
    
    func insert(to newIndexPath: IndexPath?) {
        if let indexPath = newIndexPath {
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func update(indexPath: IndexPath?, object: Word) {
        if let indexPath = indexPath {
            let cell = tableView.cellForRow(at: indexPath) as? WordCell
            cell?.configure(model: object)
        }
    }
    
    func move(from indexPath: IndexPath?, to newIndexPath: IndexPath?) {
        if let indexPath = indexPath {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        if let newIndexPath = newIndexPath {
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    func delete(indexPath: IndexPath?) {
        if let indexPath = indexPath {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func updateSection(sectionName: String) {

    }
}

extension DictionaryViewController {
    
    @IBAction func changeValueOfSegment(_ sender: Any) {
        let bool = segmetController.selectedSegmentIndex == 0 ? false : true
        presenter.setUpFrc(isKnow: bool)
        tableView.reloadData()
    }
    
    @IBAction func addNewWord(_ sender: Any) {
        addWord()
    }
    
    @objc func addWord() {
        presenter.selectedWordIndex = nil
        performSegue(withIdentifier: "addWordSegue", sender: nil)
    }
}

extension DictionaryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWordSegue", let dest = segue.destination as? EditingViewController {
            dest.word = presenter.getSelectedWord(segmentState: segmetController.selectedSegmentIndex)
        }
    }
}
