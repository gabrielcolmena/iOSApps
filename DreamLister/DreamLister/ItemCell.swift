//
//  ItemCell.swift
//  DreamLister
//
//  Created by Gabriel Colmenares on 7/6/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet var thumb: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var details: UILabel!
    
    func configureCell(item: Item){
    
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
        
    }
    
}
