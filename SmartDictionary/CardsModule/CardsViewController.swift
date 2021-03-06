//
//  CardsViewController.swift
//  SmartDictionaty
//
//  Created by Андрей Коноплев on 21.02.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import SwiftyJSON

class CardsViewController: UIViewController, CardViewInput {
    
    @IBOutlet weak var cardMainConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var swipableView: SwipableViews!
    
    var presenter = CardPresenter()
    var voiceUpCard = [CardView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCards()
        presenter.view = self
        presenter.viewDidLoad()
        configureSegmentView()
        
        if UIScreen.main.bounds.width <= 440 {
            swipableView.heightAnchor.constraint(equalTo: swipableView.widthAnchor, multiplier: 3.0/2.0).isActive = true
        } else {
            swipableView.heightAnchor.constraint(equalTo: swipableView.widthAnchor, multiplier: 2.4/2.0).isActive = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        safeVoice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpBackgroundImage(imageName: const.app_settings.app_language?.lang_image ?? "")
        segment.selectedSegmentIndex = 0
        presenter.clearArray()
        presenter.getWords(isKnow: false)
        swipableView.reloadDAta1()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func reloadData() {
        
    }
}

extension CardsViewController: SwipableViewsDelegate, SwipableViewsDataSource {

    func numberOfViews() -> Int {
        return presenter.numberOfEntities()
    }
    
    func view(view: UIView, atIndex index: Int) {
        (view as! CardView).configure(obj: presenter.entityAt(index: index) as! Word, vc: self, frame: self.view.frame)
    }
    
    func willSwiped(direction: swipeDirection, index: Int) {
        if index == presenter.numberOfEntities() - 1  {
            presenter.getWords(isKnow: segment.selectedSegmentIndex == 0 ? false : true)
            swipableView.reloadData()
        }
        
        if direction == .right && segment.selectedSegmentIndex == 0 {
            presenter.updateWordToKnown(obj: presenter.entityAt(index: index) as! Word)
        }
        
        if direction == .left && segment.selectedSegmentIndex == 1 {
            presenter.updateWordToUnknown(obj: presenter.entityAt(index: index) as! Word)
        }
    }
}

extension CardsViewController {
    func addCards() {
        let nib = UINib(nibName: "CardView", bundle: nil)
        swipableView.registerNib(nib: nib)
        swipableView.delegate = self
        swipableView.dataSource = self
        swipableView.layer.cornerRadius = 30
    }
    
    func configureSegmentView() {
        segmentView.clipsToBounds = true
        segmentView.layer.cornerRadius = 16
        segmentView.layer.borderWidth = 0
    }
    
    func safeVoice() {
        for card in voiceUpCard {
            card.safeVoice()
        }
    }
}

extension CardsViewController {
    @IBAction func changeValueOfsegment(_ sender: Any) {
        let bool = segment.selectedSegmentIndex == 0 ? false : true
        presenter.clearArray()
        presenter.getWords(isKnow: bool)
        swipableView.reloadDAta1()
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        swipableView.autoSwipe(direction: .left)
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        swipableView.autoSwipe(direction: .right)
    }
}
