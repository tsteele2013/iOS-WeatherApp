//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Steele, Trevor on 7/20/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import Foundation
import Alamofire

class WeatherManager {
    
    ///API Key for Dark Sky.
    private let apiKey = "e492180da724ac1e28d7cd6846bb98c0"
    
    ///Singleton instance of the WeatherManager class. The app uses this instance for all operations.
    class var sharedInstance: WeatherManager {
        struct Singleton {
            static let instance = WeatherManager()
        }
        return Singleton.instance
    }
    
    /**
     Gets weather data for a given location using the coordinates passed in.
     
     - Parameter latitude: Latitude for a given location.
     - Parameter longitude: Longitude for a given location.
     
     - Returns: NSDictionary with weather data.
    */
    func getWeatherForLocationWithCoordinates(latitude: Double, longitude: Double) -> [String : AnyObject] {
        let url = "https://api.forecast.io/forecast/\(apiKey)/\(latitude),\(longitude)"
        var weatherDictionary = [String : AnyObject]()
        Alamofire.request(.GET, url).responseJSON(completionHandler: { Response in
            if let data = Response.data {
                do {
                    weatherDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String : AnyObject]
                    print(weatherDictionary)
                } catch {
                    print("Error bitch")
                }
            }
        })
        return weatherDictionary
    }
}