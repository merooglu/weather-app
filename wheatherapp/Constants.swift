//
//  Constants.swift
//  wheatherapp
//
//  Created by Mehmet Eroğlu on 12.10.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
let LATİTUDE = "lat="
let LONGİTUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "db1db3db8e223ad1bfa5ee6d55bc9fe1"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATİTUDE)41.03\(LONGİTUDE)28.97\(APP_ID)\(API_KEY)"
let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast?lat=41.03&lon=28.97&appid=db1db3db8e223ad1bfa5ee6d55bc9fe1"
