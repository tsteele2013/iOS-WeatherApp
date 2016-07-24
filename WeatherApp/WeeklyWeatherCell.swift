//
//  WeeklyWeatherCell.swift
//  WeatherApp
//
//  Created by Trevor Steele on 7/24/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import Foundation
import UIKit

class WeeklyWeatherCell: UITableViewCell {
    
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func updateWithWeatherItem(weatherItem: WeeklyWeatherItem) {
        weekdayLabel.text = weatherItem.time
        maxTempLabel.text = "H: \(String(weatherItem.temperatureMax))˚"
        minTempLabel.text = "L: \(String(weatherItem.temperatureMin))˚"
    }
}