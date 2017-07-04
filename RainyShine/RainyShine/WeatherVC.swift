//
//  WeatherVC
//  RainyShine
//
//  Created by Gabriel Colmenares on 6/28/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet var locationLbl: UILabel!
    @IBOutlet var weatherLbl: UILabel!
    @IBOutlet var tempLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundImage: UIImageView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        locationLbl.text = ""
        weatherLbl.text = ""
        tempLbl.text = ""
        dateLbl.text = ""
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather = CurrentWeather()
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData{
                    self.updateMainUI()
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        Alamofire.request(FORECAST_FULL_URL).responseJSON{response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for obj in list{
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
            
        }else{
            return WeatherCell()
        }
    }
    
    func updateMainUI(){
        locationLbl.text = currentWeather.location
        dateLbl.text = currentWeather.date
        weatherLbl.text = currentWeather.weatherType
        tempLbl.text = "\(currentWeather.currentTemp)"
        backgroundImage.image = UIImage(named: "\(currentWeather.weatherType)_bg")
    }

}

