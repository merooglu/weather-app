//
//  WeatherVC.swift
//  wheatherapp
//
//  Created by Mehmet Eroğlu on 11.10.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManeger = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecastsArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManeger.delegate = self
        locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManeger.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                // Setup UI to download the data
                self.downloadForecastData {
                    self.updateMainUI()
                    self.tableView.reloadData()
                }
            }
        } else {
            locationManeger.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        locationLabel.text = currentWeather.cityName
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImageView.image = UIImage(named: currentWeather.weatherType)
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Downloading forecast wether data
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { (respose) in
            let result = respose.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecastsArray.append(forecast)
                        print("---object: \(obj)")
                    }
                    self.forecastsArray.remove(at: 0)
                }
            }
            completed()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherTVCell", for: indexPath) as? WeatherTVCell {
            weatherCell.configureCell(forecast: forecastsArray[indexPath.row])
             return weatherCell
        }else {
            return WeatherTVCell()
        }
    }

}

