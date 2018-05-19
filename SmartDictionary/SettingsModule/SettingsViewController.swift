//
//  SettingsViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBAction func selectPressed(_ sender: Any) {
        if pickerView.isHidden {
            pickerView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectButton.setTitle(const.app_settings.app_language?.name, for: .normal)
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return const.languages.langArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectLang = const.languages.langArray[row]
        
        CurrentLanguageFabrique.updateCurrentLang(name: selectLang.name, api_locale: selectLang.api_locale, speach_locale: selectLang.speach_locale, lang_image: selectLang.imgLang, context: CoreDataManager.sharedInstance.getMainContext())
        
        selectButton.setTitle(const.app_settings.app_language?.name ?? "" , for: .normal)
        pickerView.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let myTitle = NSAttributedString(string: const.languages.langArray[row].name, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.black])
        return myTitle
    }
}



