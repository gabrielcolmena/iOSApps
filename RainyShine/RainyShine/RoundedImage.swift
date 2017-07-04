//
//  RoundedImage.swift
//  RainyShine
//
//  Created by Gabriel Colmenares on 6/30/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }

}
