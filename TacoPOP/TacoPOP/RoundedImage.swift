//
//  RoundedImage.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/14/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

private var roundedKey = false

extension UIImageView {
    
    @IBInspectable var rounded: Bool{
        get{
            return roundedKey
        }
        set{
            roundedKey = newValue
            
            if roundedKey{
                self.layer.cornerRadius = self.layer.frame.size.width/2
                self.clipsToBounds = true
            }else{
                self.clipsToBounds = false
            }
        }
    }
}
