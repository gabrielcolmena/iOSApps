//
//  MaterialButton.swift
//  DreamLister
//
//  Created by Gabriel Colmenares on 7/8/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

private var materialKey = false

extension UIButton {
    
    @IBInspectable var materialLook: Bool{
        get{
            return materialKey
        }
        set{
            materialKey = newValue
            
            if materialKey{
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 2
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(colorLiteralRed: 157/255, green: 157/255, blue: 157/233, alpha: 1.0).cgColor
            }else{
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
    
}
