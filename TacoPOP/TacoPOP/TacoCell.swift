//
//  TacoCell.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/13/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class TacoCell: UICollectionViewCell, NibLoadableView, Shakeable {

    @IBOutlet weak var tacoImage: UIImageView!
    @IBOutlet weak var tacoLabel: UILabel!
    
    var taco: Taco!
    
    func configureCell(taco: Taco){
        self.taco = taco
        self.tacoImage.image = UIImage(named: taco.proteinId.rawValue)
        self.tacoLabel.text = taco.productName
    }
    
}
