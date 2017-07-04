//
//  Constants.swift
//  RainyShine
//
//  Created by Gabriel Colmenares on 7/1/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import Foundation

let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"

let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APPID = "&appid="
let API_KEY = "4b3b31aa9a87eb28584a8b84d19ec05f"

let CNT = "&cnt="

let LIST_LENGTH = 7

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(WEATHER_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APPID)\(API_KEY)"
let FORECAST_FULL_URL = "\(FORECAST_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APPID)\(API_KEY)\(CNT)\(LIST_LENGTH)"
