//
//  CurrentWeather.swift
//  wheatherapp
//
//  Created by Mehmet Eroğlu on 12.10.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

/**
Request response
SUCCESS: {
    base = stations;
    clouds =     {
        all = 90;
    };
    cod = 200;
    coord =     {
        lat = "21.28";
        lon = "-157.83";
    };
    dt = 1583268787;
    id = 5856195;
    main =     {
        "feels_like" = "300.9";
        humidity = 78;
        pressure = 1019;
        temp = "298.21";
        "temp_max" = "299.26";
        "temp_min" = "296.15";
    };
    name = Honolulu;
    sys =     {
        country = US;
        id = 7877;
        sunrise = 1583254188;
        sunset = 1583296602;
        type = 1;
    };
    timezone = "-36000";
    visibility = 16093;
    weather =     (
                {
            description = "overcast clouds";
            icon = 04d;
            id = 804;
            main = Clouds;
        }
    );
    wind =     {
        deg = 300;
        speed = "2.1";
    };
}
*/

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
            print("Response: \n",response)
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
