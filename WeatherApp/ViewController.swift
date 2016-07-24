//
//  ViewController.swift
//  WeatherApp
//
//  Created by Steele, Trevor on 7/20/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    private let apiKey = "e492180da724ac1e28d7cd6846bb98c0"
    var lon = CLLocationDegrees()
    var lat = CLLocationDegrees()
    
    @IBOutlet weak var currentWeatherTemp: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        print(locationManager.location?.coordinate)
        
        
    }
    
    @IBAction func getMyLatAndLon(sender: AnyObject) {
        lat = 39.680833
        lon = -86.1446394
        
        getWeatherForLocationWithCoordinates(lat, longitude: lon)
       
    }
    
    func getWeatherForLocationWithCoordinates(latitude: Double, longitude: Double) {
        UIView.animateWithDuration(1.0, animations: {
            self.currentWeatherTemp.alpha = 0.0
            if self.currentWeatherTemp.textColor == UIColor.redColor() {
                self.currentWeatherTemp.textColor = UIColor.blueColor()
            } else {
                self.currentWeatherTemp.textColor = UIColor.redColor()
            }
        })
        
        let url = "https://api.forecast.io/forecast/\(apiKey)/\(latitude),\(longitude)"
        var weatDictionary = NSDictionary()
        Alamofire.request(.GET, url).responseJSON(completionHandler: { Response in
            if let data = Response.data {
                do {
                    weatDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
                    let currentWeather = CurrentWeather(weatherDictionary: weatDictionary)
                    var hourlyWeatherArray = [HourlyWeatherItem]()
                    if let hourlyWeather = weatDictionary["hourly"]!["data"] as? NSArray {
                        for i in 0...(hourlyWeather.count - 1) {
                            let item = HourlyWeatherItem(hourlyWeather: hourlyWeather, index: i)
                            hourlyWeatherArray.append(item)
                        }
                    }
                    
                    //let weeklyWeather = WeeklyWeather(weatherDictionary: weatDictionary)
                    //print(weatDictionary)
                    

                    self.currentWeatherTemp.text = String(currentWeather.temperature)
                    self.currentWeatherTemp.alpha = 1.0
                    self.currentWeatherImageView.image = UIImage(named: "")



                    
                    
                } catch {
                    print("Error bitch")
                }
            }
        })
    }
    
}

//MARK: CLLocationManagerDelegate
extension ViewController {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location.coordinate)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}