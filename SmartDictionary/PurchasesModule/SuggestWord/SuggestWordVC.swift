//
//  SuggestWordVC.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 22.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class SuggestWordVC: UIViewController {

    @IBOutlet weak var wordLabel: UITextField!
    @IBOutlet weak var translateLabel: UITextField!
    

    @IBAction func pushToSuggest(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Предложить слово"
        setColors()
    }
}

extension SuggestWordVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//work with navbar
extension SuggestWordVC {
    func setColors() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black]
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
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
}
