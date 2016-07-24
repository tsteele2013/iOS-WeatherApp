//
//  HourlyWeatherItem.swift
//  WeatherApp
//
//  Created by Trevor Steele on 7/24/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import Foundation

struct HourlyWeatherItem {
    
    var hourlyTime: String?
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    //    var icon: UIImage
    var windSpeed: Double
    
    init (hourlyWeather: NSArray, index: Int) {
        
        temperature = hourlyWeather[index]["temperature"] as! Int
        humidity = hourlyWeather[index]["humidity"] as! Double
        precipProbability = hourlyWeather[index]["precipProbability"] as! Double
        windSpeed = hourlyWeather[index]["windSpeed"] as! Double
        if let hourlyTimeIntValue = hourlyWeather[index]["time"] as? Int {
            hourlyTime = dateStringFromUnixtime(hourlyTimeIntValue)
        }
        //        let iconString = hourlyWeather[index]["icon"]as! String
        //        icon = weatherIconFromString(iconString)
    }
}