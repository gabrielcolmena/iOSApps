//
//  constants.swift
//  PokeApp
//
//  Created by Gabriel Colmenares on 7/4/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import Foundation
import UIKit

let BASE_URL = "http://pokeapi.co/api/v1/pokemon/"
let V2BASE_URL = "http://pokeapi.co/api/v2/pokemon/"

let colorsDict: [String: String] = 	["normal": "#aaa87a" ,"fighting": "#b1150d" ,"flying": "#a891f2" ,"poison": "#9a3f9f" ,"ground": "#dfbc65" ,"rock": "#b6a038" ,"bug": "#a8b821" ,"ghost": "#6d5798" ,"steel": "#b7b8d0" ,"fire": "#ef7f2f" ,"water": "#6492f4" ,"grass": "#7ac852" ,"electric": "#fad229" ,"psychic": "#f85a89" ,"ice": "#98d8d7" ,"dragon": "#753afe" ,"dark": "#6f5947" ,"fairy": "#ffaec9"]

typealias DownloadComplete = () -> ()


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
