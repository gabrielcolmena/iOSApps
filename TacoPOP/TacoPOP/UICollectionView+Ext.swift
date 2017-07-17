//
//  UICollectionView+Ext.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/14/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

extension UICollectionView{
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusebleView, T: NibLoadableView{
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusebleView{
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else{
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}

extension UICollectionViewCell: ReusebleView{}
