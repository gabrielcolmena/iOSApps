    //
//  MutableCollection+Ext.swift
//  TacoPOP
//
//  Created by Gabriel Colmenares on 7/16/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import Foundation
    
extension MutableCollection where Index == Int{
    mutating func suffle(){
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1{
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else {continue}
            swap(&self[i], &self[j])
        }
    }
}
