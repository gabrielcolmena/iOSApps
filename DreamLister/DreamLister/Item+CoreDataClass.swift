//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Gabriel Colmenares on 7/5/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import Foundation
import CoreData

//@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
