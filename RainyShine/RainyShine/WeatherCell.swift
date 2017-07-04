//
//  WeatherCell.swift
//  RainyShine
//
//  Created by Gabriel Colmenares on 7/2/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var weatherTypeLbl: UILabel!
    @IBOutlet var highTempLbl: UILabel!
    @IBOutlet var lowTempLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!

    func configureCell(forecast: Forecast){
        dateLbl.text = forecast.date
        lowTempLbl.text = forecast.lowTemp
        highTempLbl.text = forecast.highTemp
        weatherTypeLbl.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    
}
