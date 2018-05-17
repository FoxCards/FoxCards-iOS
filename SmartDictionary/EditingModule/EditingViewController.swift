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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Новое слово"
        if word != nil {
            navigationItem.title = word!.word
            WordTextField.text = word!.word
            translateTextField.text = word!.translate
            transcriptionTextField.text = word!.transcriptions
            knownSwitch.isOn = word!.isKnow
            WordTextField.isEnabled = false
        } else {
            knownSwitch.isOn = false
        }
    }
    
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
        if WordTextField.text != "" {
            presenter.save(word: WordTextField.text!, transcription: transcriptionTextField.text!, translate: translateTextField.text!, isKnown: knownSwitch.isOn)
            self.navigationController?.popViewController(animated: true)
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

extension EditingViewController {
//    func setNavBatItem() {
//        let imageView = UIImageView()
//        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "\(String(describing: const.app_settings.app_language?.speach_locale ?? "" )).png")
//        let barButtonItem = UIBarButtonItem(customView: imageView)
//        navigationItem.rightBarButtonItem = barButtonItem
//
//    }
}
