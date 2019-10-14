//
//  WeatherTVCell.swift
//  wheatherapp
//
//  Created by Mehmet Eroğlu on 14.10.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

import UIKit

class WeatherTVCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    
    func configureCell(forecast: Forecast){
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        highTempLabel.text = "\(forecast.maxTemp)"
        lowTempLabel.text = "\(forecast.minTemp)"
        weatherTypeImageView.image = UIImage(named: forecast.weatherType)
    }

}
