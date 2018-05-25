//
//  TranslateViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 02.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, TranslateViewInput {
    
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var fromLangLabel: UILabel!
    @IBOutlet weak var toLangLabel: UILabel!
    @IBOutlet weak var saveWord: UIButton!
    
    let debauncer = Debouncer(interval: 0.8)
    var presenter = TranslatePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        translateTextField.delegate = self
        saveWord.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fromLangLabel.text = const.app_settings.app_language?.name ?? ""
        toLangLabel.text = "Русский"
        clearAllText()
        saveWord.isEnabled = false
    }

    func reloadData() {
    }
}

extension TranslateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        translateTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        translateTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let data = textField.text!
            var newData = String()
            
            if string != "" {
                newData = data + string
            } else {
                newData = String(data.dropLast())
            }
        
            self.saveWord.isEnabled = newData != ""
            if newData != "" {
                debauncer.callback = {
                    let locale = self.fromLangLabel.text == "Русский" ? const.app_settings.app_language?.reverseApiLocale() ?? "" : const.app_settings.app_language?.api_locale ?? ""
                    DataProvider.getTranslate(text: newData, locale: locale, success: { (text) in
                        DispatchQueue.main.async {
                            self.translateLabel.text = text
                        }
                    }) { (error) in
                        print(error)
                    }
                }
            } else {
                self.translateLabel.text = ""
            }
        debauncer.call()
        return true
    }
}

extension TranslateViewController {
    func clearAllText() {
        translateLabel.text = ""
        translateTextField.text = ""
    }
    
    func getAlert(string: String) {
        let alert = UIAlertController(title: "Ошибка", message: string, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//actions
extension TranslateViewController {
    
    @IBAction func redirectlang(_ sender: Any) {
        clearAllText()
        if self.fromLangLabel.text == "Русский" {
            self.fromLangLabel.text = const.app_settings.app_language?.name ?? ""
            self.toLangLabel.text = "Русский"
        } else {
            self.fromLangLabel.text = "Русский"
            self.toLangLabel.text = const.app_settings.app_language?.name ?? ""
        }
    }
    
    @IBAction func pushToSaveWord(_ sender: Any) {
        if translateTextField.text != "" {
            if self.fromLangLabel.text == "Русский" && self.translateLabel.text != "" {
                presenter.save(word: translateLabel.text!, transcription: "", translate: translateTextField.text!, isKnown: false)
            } else if self.fromLangLabel.text == "Русский" && self.translateLabel.text == "" {
                getAlert(string: "Слова сохраняются в словарь в формате **-ru, если слово ** языка не опознано, сохранение не возможно")
            } else {
                presenter.save(word: translateTextField.text!, transcription: "", translate: translateLabel.text!, isKnown: false)
            }
            
            clearAllText()
            saveWord.isEnabled = false
            translateTextField.resignFirstResponder()
        }
    }
    
    @IBAction func tapToScreen(_ sender: Any) {
        self.view.endEditing(true)
    }
}
