//
//  EditingViewController.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 26.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {
    
    var word: Word?
    let presenter = EditingPresenter()

    
    @IBOutlet weak var WordTextField: UITextField!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var transcriptionTextField: UITextField!
    @IBOutlet weak var knownSwitch: UISwitch!
    
    @IBAction func pushToTranslate(_ sender: Any) {
        if WordTextField.text != "" {
            DataProvider.getTranslate(text: WordTextField.text!, locale: const.app_settings.app_language?.api_locale ?? "", success: { [weak self] (translate) in
                DispatchQueue.main.async {
                    self?.translateTextField.text = translate
                }
                
            }) { (error) in
                print(error)
            }
        }
    }
    
    @IBAction func pushToSave(_ sender: Any) {
        presenter.save(word: WordTextField.text!, transcription: transcriptionTextField.text!, translate: translateTextField.text!, isKnown: knownSwitch.isOn)
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Новое слово"
        
        if word != nil {
            navigationItem.title = word!.word
            WordTextField.text = word!.word
            translateTextField.text = word!.translate
            transcriptionTextField.text = word!.transcriptions
            knownSwitch.isOn = word!.isKnow
        } else {
            knownSwitch.isOn = false
        }
    }
}

extension EditingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
