//
//  MainVC.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/12/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class MainVC: UIViewController, DataServiceDelegate {
    
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var collectionView: UICollectionView!
    
    var dataservice: DataService = DataService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataservice.delegate = self
        dataservice.loadDeliciousTacoData()
        dataservice.tacoArray.suffle()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        headerView.addDropShadow()
        collectionView.register(TacoCell.self)
    }
    
    func deliciousTacoDataLoaded() {
        print("Taco data loaded!")
        collectionView.reloadData()
    }

}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(forIndexPath: indexPath) as TacoCell
        cell.configureCell(taco: dataservice.tacoArray[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataservice.tacoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TacoCell{
            cell.shake()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
}
