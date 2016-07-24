//
//  HelperFunctions.swift
//  WeatherApp
//
//  Created by Steele, Trevor on 7/21/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import Foundation
import UIKit

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

/**
 Returns truncated day name (i.e. "Sun") from Unix time Int.
 
 - Parameter unixTime: Unix time Int.
 
 - Returns: String of truncted weekday name.
 */
func weekDateShortStringFromUnixtime(unixTime: Int) -> String {
    
    let timeInSeconds = NSTimeInterval(unixTime)
    let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
    
    let dateFormatter = NSDateFormatter()
    //dateFormatter.timeStyle = .MediumStyle
    dateFormatter.dateFormat = "EEE"
    
    return dateFormatter.stringFromDate(weatherDate)
}

/**
 Returns truncated day name (i.e. "Sun") from Unix time Int.
 
 - Parameter unixTime: Unix time Int.
 
 - Returns: String of truncted weekday name.
 */
func weekDateLongStringFromUnixtime(unixTime: Int) -> String {
    
    let timeInSeconds = NSTimeInterval(unixTime)
    let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
    
    let dateFormatter = NSDateFormatter()
    //dateFormatter.timeStyle = .MediumStyle
    dateFormatter.dateFormat = "EEEE"
    
    return dateFormatter.stringFromDate(weatherDate)
}

/**
 Returns time of day (i.e. "3:10:00 PM") from Unix time Int.
 
 - Parameter unixTime: Unix time Int.
 
 - Returns: Time of day as String.
 */
func dateStringFromUnixtime(unixTime: Int) -> String {
    
    let timeInSeconds = NSTimeInterval(unixTime)
    let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = .MediumStyle
    
    return dateFormatter.stringFromDate(weatherDate)
}


