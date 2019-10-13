//
//  Forecast.swift
//  wheatherapp
//
//  Created by Mehmet Eroğlu on 13.10.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

import UIKit

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _minTemp: String!
    var _maxTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var minTemp: String {
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = ""
        }
        return _maxTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
            if let temp_min = main["temp_min"] as? Double {
                self._minTemp = "\(temp_min - 273.15)"
            }
            
            if let temp_max = main["temp_max"] as? Double {
                self._maxTemp = "\(temp_max - 273.15)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfWeek()
        }
        
    }
    
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
