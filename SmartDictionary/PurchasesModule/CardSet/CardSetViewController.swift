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
    var thisSet: CardSetModel? { get set }
    func reloadData()
}

class CardSetViewController: UIViewController, CardSetViewInput {
    
    func reloadData() {
        self.tableVIew.reloadData()
    }
    
    @IBOutlet weak var tableVIew: UITableView!
    var thisSet : CardSetModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        //SVProgressHUD.show()
        self.thisSet = CardSetModel(id: 1, name: "Test", img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeGYabOnW8fIZNTjACJfzgS82zLD92t7jZhYnILf7yRjgcFI6a", locale: "en-ru", word_count: 1)
        thisSet?.words = [WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"), WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский"),WordModel(word: "Test", transcription: "Test", translate: "Test", language: "Английский")]
        self.tableVIew.tableHeaderView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), model: self.thisSet!, vc: self)
//        _ = DataProvider.getCardSet(by: 1, success: { (response) in
//            DispatchQueue.main.async {
//                self.thisSet = response
//                self.tableVIew.tableHeaderView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200), model: self.thisSet!, vc: self)
//                self.tableVIew.reloadData()
//                SVProgressHUD.dismiss()
//            }
//        })
        
        self.tableVIew.contentInset = UIEdgeInsetsMake(-44,0,0,0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
}

extension CardSetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisSet?.words?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "carSetWordCell", for: indexPath) as! CardSetWordCell
        cell.configure(word: thisSet?.words?[indexPath.row].word ?? "", translate: thisSet?.words?[indexPath.row].translate ?? "")
        return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = (scrollView.contentOffset.y - 100) / 150
        if offset > 1 {
            offset = 1
            self.navigationController?.navigationBar.tintColor = UIColor(hue: 1, saturation: offset, brightness: 1, alpha: 1)
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
            }, completion: nil)
    }
    
    private func setColors(){
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }

}

