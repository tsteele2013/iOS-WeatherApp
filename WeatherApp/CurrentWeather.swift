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


/// Takes date in Unix time and returns a nicely formatted string.
func dateStringFromUnixtime(unixTime: Int) -> String {
    
    let timeInSeconds = NSTimeInterval(unixTime)
    let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = .MediumStyle
    
    return dateFormatter.stringFromDate(weatherDate)
    
    
}


///Return appropriate weather image based on string passed in.
func weatherIconFromString(stringIcon: String) -> UIImage {
    
    var imageName: String
    
    switch stringIcon {
    case "clear-day":
        imageName = "clear-day"
    case "clear-night":
        imageName = "clear-night"
    case "rain":
        imageName = "rain"
    case "snow":
        imageName = "snow"
    case "sleet":
        imageName = "sleet"
    case "wind":
        imageName = "wind"
    case "fog":
        imageName = "fog"
    case "cloudy":
        imageName = "cloudy"
    case "partly-cloudy-day":
        imageName = "partly-cloudy"
    case "partly-cloudy-night":
        imageName = "cloudy-night"
    default:
        imageName = "default"
    }
    
    let iconImage = UIImage(named: imageName)
    return iconImage!
}

func Fahrenheit2Celsius(f: Int) -> Int {
    return Int((Double(f)-32.0) / 1.8)
}