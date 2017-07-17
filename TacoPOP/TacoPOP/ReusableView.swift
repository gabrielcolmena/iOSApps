//
//  ReusableView.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/14/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

protocol ReusebleView: class{}

extension ReusebleView where Self: UIView{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}


