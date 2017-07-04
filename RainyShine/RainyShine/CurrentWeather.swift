//
//  CurrentWeather.swift
//  RainyShine
//
//  Created by Gabriel Colmenares on 7/1/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _location: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: String!
    
    var location: String{
        if _location == nil{
            _location = ""
        }
        return _location
    }
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"

        return _date
    }
    
    var weatherType: String{
        if _weatherType == nil{
           _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String{
        if _currentTemp == nil{
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String{
                    let cityName = name.capitalized
                    
                    if let sys = dict["sys"] as? Dictionary<String, AnyObject> {
                        if let country = sys["country"] as? String{
                            self._location = "\(cityName), \(country)"
                        }
                    }
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    if let currentTemperature = main["temp"] as? Double{
                        let kelvinToCelcius = (currentTemperature - 273.15)
                        self._currentTemp = " \(Int(kelvinToCelcius))°"
                    }
                }
            }
            completed()
        }
    }
}
