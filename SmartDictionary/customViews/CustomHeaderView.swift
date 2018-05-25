//
//  CustomHeaderView.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 14.04.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD


class CustomHeaderView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    @IBOutlet weak var suggestButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let saveWordsService = SaveWordService()
    var viewController: UIViewController?
    var model: CardSetModel?
    
    @IBAction func pushToSuggestWord(_ sender: Any) {
        self.viewController?.performSegue(withIdentifier: "toSuggestWord", sender: nil)
    }
    @IBAction func pushToAddToDictionary(_ sender: Any) {
        guard let words = self.model?.words else { return }
        saveWordsService.saveWords(words: words, success: {
            SVProgressHUD.showSuccess(withStatus: "Сохранено в ваш словарь")
        })
    }

    init(frame: CGRect, model: CardSetModel, vc: UIViewController) {
        super.init(frame: frame)
        self.viewController = vc
        self.model = model
        commonInit()
        self.imageVIew.alpha = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomHeaderView", owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        self.addButton.layer.cornerRadius = 5
        self.imageVIew.kf.setImage(with: URL(string: self.model?.img ?? ""))
        self.wordsCountLabel.text = "Всего слов в наборе: \(self.model!.word_count)"
    }

}
