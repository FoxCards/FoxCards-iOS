//
//  SetUpWizardVC.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 12.05.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class SetUpWizardVC: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pagingControll: UIPageControl!
    var arrayVideo = ["JTSP24141", "JTSP2414", "JTSP24142"]
    var arrayText = ["Первыфа ыфав фвыа ывф авфы авыфа выфа выфа вфыа фвыа выфа выфа вфыа фвыа", "Первыфа ыфав фвыа ывф авфы авыфа выфа выфа вфыа фвыа выфа выфа вфыа фвыа", "Первыфа ыфав фвыа ывф авфы авыфа выфа выфа вфыа фвыа выфа выфа вфыа фвыа"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNib()
        pagingControll.numberOfPages = 4
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SetUpWizardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0,2:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "firstWizardCell", for: indexPath) as! FirstWizardCell
            cell.configure(media: arrayVideo[indexPath.row], text: arrayText[indexPath.row], index: indexPath.row, vc: self)
            return cell
        case 1:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "langSelectCell", for: indexPath) as! SelectLanguageCell
            cell.configure(vc: self)
            return cell
        case 3:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "startCell", for: indexPath) as! FinalWizardCell
            cell.configure(vc: self)
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        self.pagingControll.currentPage = currentPage
    }
}

extension SetUpWizardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}

extension SetUpWizardVC {
    func configureNib() {
        let nib1 = UINib(nibName: "FirstWizardCell", bundle: nil)
        self.collectionView.register(nib1, forCellWithReuseIdentifier: "firstWizardCell")
        let nib2 = UINib(nibName: "SelectLanguageCell", bundle: nil)
        self.collectionView.register(nib2, forCellWithReuseIdentifier: "langSelectCell")
        let nib3 = UINib(nibName: "FinalWizardCell", bundle: nil)
        self.collectionView.register(nib3, forCellWithReuseIdentifier: "startCell")
    }
}
