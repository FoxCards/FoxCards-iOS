//
//  FirstWizardCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit
import MediaPlayer

class FirstWizardCell: UICollectionViewCell {
    
    
    @IBOutlet weak var textLabel: UILabel!
    var moviePlayer: MPMoviePlayerController?
    var vc: SetUpWizardVC?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
       
    }
    
    @IBAction func next(_ sender: Any) {
        self.moviePlayer?.stop()
        self.moviePlayer?.view.isHidden = true
        self.vc?.collectionView?.scrollToItem(at: IndexPath(row: (self.index ?? 0) + 1, section: 0), at: .centeredHorizontally, animated: true)
        self.vc?.pagingControll.currentPage = self.index! + 1
    }
        
    func configure(media: String,text: String,index: Int, vc: SetUpWizardVC) {
        self.vc = vc
        self.textLabel.text = text
        self.index = index
        let path = Bundle.main.path(forResource: media, ofType: "m4v")
        let url = URL(fileURLWithPath: path!)
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
           self.moviePlayer?.view.frame = CGRect(x: 10, y: 30, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 300)
        } else {
            self.moviePlayer?.view.frame = CGRect(x: 10, y: 30, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 250)
        }
        self.moviePlayer?.backgroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.moviePlayer?.controlStyle = .none
        self.moviePlayer?.repeatMode = .one
        self.moviePlayer?.prepareToPlay()
            
        self.addSubview((moviePlayer?.view!)!)
    }
}
