//
//  SelectLanguageCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class SelectLanguageCell: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    let context = CoreDataManager.sharedInstance.getMainContext()
    var vc: SetUpWizardVC?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func configure(vc: SetUpWizardVC) {
        self.vc = vc
    }
}



extension SelectLanguageCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return const.languages.langArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "langCell", for: indexPath) as! LanguageCell
        cell.configure(LanguageModel: const.languages.langArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setUpLanguage(lang: const.languages.langArray[indexPath.row])
        vc?.collectionView.scrollToItem(at: IndexPath(row: 2, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SelectLanguageCell {
    func setUpCell() {
        let nib = UINib(nibName: "LanguageCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "langCell")
    }
    
    func setUpLanguage(lang: LanguageModel) {
        CurrentLanguageFabrique.updateCurrentLang(name: lang.name, api_locale: lang.api_locale, speach_locale: lang.speach_locale, lang_image: lang.imgLang, context: self.context)
        CoreDataManager.sharedInstance.saveContext()
        const.app_settings.app_language = CurrentLanguageFabrique.getCurrentLang(context: context)
    }
}
