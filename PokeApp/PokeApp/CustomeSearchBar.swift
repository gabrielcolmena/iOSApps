//
//  CustomeSearchBar.swift
//  PokeApp
//
//  Created by Gabriel Colmenares on 7/4/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class CustomeSearchBar: UISearchBar {

    override func awakeFromNib() {
        self.setTextColor(color: UIColor.white)
    }

}

public extension UISearchBar {
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}

