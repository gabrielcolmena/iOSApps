//
//  Location.swift
//  RainyShine
//
//  Created by Gabriel Colmenares on 7/2/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import CoreLocation

class Location{
    static var sharedInstance = Location()
    private init(){  }
    
    var latitude: Double!
    var longitude: Double!
}
