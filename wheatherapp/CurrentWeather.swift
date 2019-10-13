//
//  CurrentWeather.swift
//  wheatherapp
//
//  Created by Mehmet Eroğlu on 12.10.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
      
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Download the current weather data
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            print(response)
            if let dictionary = result.value as? Dictionary<String, AnyObject> {//[String: AnyObject]
                
                if let name = dictionary["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>] { // [[String: AnyObject]]
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dictionary["main"] as? Dictionary<String, AnyObject> {
                    if let currentTempreture = main["temp"] as? Double {
                        let kelvinToCelcius = round(currentTempreture - 273.15)
                        self._currentTemp = kelvinToCelcius
                        print(self._currentTemp)
                    }
                }
                
            }
            completed()
        }
        
    }
    
}
