//
//  RoundedLabel.swift
//  PokeApp
//
//  Created by Gabriel Colmenares on 7/5/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {

    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
