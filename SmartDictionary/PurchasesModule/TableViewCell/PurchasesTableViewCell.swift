//
//  PurchasesTableViewCell.swift
//  SmartDictionary
//
//  Created by Андрей Коноплев on 15.03.2018.
//  Copyright © 2018 Андрей Коноплев. All rights reserved.
//

import UIKit

class PurchasesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [CardSetModel]?
    weak var vc: PurchasesViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerNib()
    }
    
    func configure(dataSource: [CardSetModel], vc: PurchasesViewController) {
        self.dataSource = dataSource
        self.vc = vc
    }
}

extension PurchasesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cardSetsCell", for: indexPath) as! CardSetsCell
        cell.configure(flagImg: dataSource?[indexPath.row].locale ?? "", model: dataSource?[indexPath.row])
        //MARK:- make shadow
        cell.contentView.layer.cornerRadius = 10
        cell.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 0.8
        cell.contentView.layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        cell.contentView.layer.masksToBounds = true;
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 1.0)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        vc?.id = self.dataSource?[indexPath.row].id
        vc?.performSegue(withIdentifier: "cardsToCard", sender: nil)
    }
}

extension PurchasesTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    }
}

extension PurchasesTableViewCell {
    func registerNib() {
        let nib = UINib(nibName: "CardSetsCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "cardSetsCell")
    }
    
    func reloadData() {
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
    }
}
