//
//  WeeklyWeather.swift
//  WeatherApp
//
//  Created by Steele, Trevor on 7/21/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import Foundation
import UIKit

struct WeeklyWeatherItem {
    
    var temperatureMax: Int
    var temperatureMin: Int
    var time: String
    //var icon: UIImage
    
    init (weeklyWeather: NSArray, index: Int) {
    
        temperatureMax = weeklyWeather[index]["temperatureMax"] as! Int
        temperatureMin = weeklyWeather[index]["temperatureMin"] as! Int
        let timeIntValue = weeklyWeather[index]["sunriseTime"] as! Int
        time = weekDateLongStringFromUnixtime(timeIntValue)
        
        
//        let iconString = weeklyWeather[index]["icon"] as! String
//        icon = weatherIconFromString(dayOneIconString)
    }
    
    
}

