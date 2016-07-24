//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Steele, Trevor on 7/20/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    
    var currentTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
//    var icon: UIImage
    var windSpeed: Double
    
    
    init (weatherDictionary: NSDictionary) {
        
        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        temperature = currentWeather["temperature"] as! Int
        humidity = currentWeather["humidity"] as! Double
        precipProbability = currentWeather["precipProbability"] as! Double
        summary = currentWeather["summary"] as! String
        windSpeed = currentWeather["windSpeed"] as! Double
        let currentTimeIntValue = currentWeather["time"] as! Int
        currentTime = dateStringFromUnixtime(currentTimeIntValue)
//        let iconString = currentWeather["icon"]as! String
//        icon = weatherIconFromString(iconString)
    }
}







func Fahrenheit2Celsius(f: Int) -> Int {
    return Int((Double(f)-32.0) / 1.8)
}