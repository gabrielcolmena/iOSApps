//
//  DropShadow.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/12/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

protocol DropShadow{}

extension DropShadow where Self: UIView{
    func addDropShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
}
