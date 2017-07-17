//
//  NibLoadableView.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/14/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

protocol NibLoadableView: class{}

extension NibLoadableView where Self: UIView{
    static var nibName: String{
        return String(describing: self)
    }
}
