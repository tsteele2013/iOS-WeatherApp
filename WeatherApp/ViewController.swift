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
    
    @IBOutlet weak var weeklyWeatherDay1Temp: UILabel!
    @IBOutlet weak var weeklyWeatherDay1TempImageView:UIImageView!
    
    @IBOutlet weak var weeklyWeatherDay2Temp: UILabel!
    @IBOutlet weak var weeklyWeatherDay2TempImageView:UIImageView!
    
    @IBOutlet weak var weeklyWeatherDay3Temp: UILabel!
    @IBOutlet weak var weeklyWeatherDay3TempImageView:UIImageView!
    
    @IBOutlet weak var weeklyWeatherDay4Temp: UILabel!
    @IBOutlet weak var weeklyWeatherDay4TempImageView:UIImageView!
    
    @IBOutlet weak var weeklyWeatherDay5Temp: UILabel!
    @IBOutlet weak var weeklyWeatherDay5TempImageView:UIImageView!
    
    @IBOutlet weak var weeklyWeatherDay6Temp: UILabel!
    @IBOutlet weak var weeklyWeatherDay6TempImageView:UIImageView!
    
    @IBOutlet weak var weeklyWeatherDay7Temp: UILabel!
    @IBOutlet weak var weeklyWeatherDay7TempImageView:UIImageView!
    
    
    
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
                    let weeklyWeather = WeeklyWeather(weatherDictionary: weatDictionary)
                    print(weatDictionary)
                    
 // CURRENT WEATHER
                    
                    self.currentWeatherTemp.text = String(currentWeather.temperature)
                    self.currentWeatherTemp.alpha = 1.0
                    self.currentWeatherImageView.image = UIImage(named: "")
// WEATHER DAY 1
                    
                    self.weeklyWeatherDay1Temp.text = "\(String(weeklyWeather.dayOneTemperatureMin)) - \(String(weeklyWeather.dayOneTemperatureMax))"
                    self.weeklyWeatherDay1TempImageView.image = UIImage(named: "")
                    self.weeklyWeatherDay1TempImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                
                    
// WEATHER DAY 2
                    
                    self.weeklyWeatherDay2Temp.text = "\(String(weeklyWeather.dayTwoTemperatureMin)) - \(String(weeklyWeather.dayTwoTemperatureMax))"
                    self.weeklyWeatherDay2TempImageView.image = UIImage(named: "")
                    self.weeklyWeatherDay2TempImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                    
                    
// WEATHER DAY 3
                    
                    self.weeklyWeatherDay3Temp.text = "\(String(weeklyWeather.dayThreeTemperatureMin))-\(String(weeklyWeather.dayThreeTemperatureMax))"
                    self.weeklyWeatherDay3TempImageView.image = UIImage(named: "")
                    self.weeklyWeatherDay3TempImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                    
// WEATHER DAY 4
                    
                    
                    self.weeklyWeatherDay4Temp.text = "\(String(weeklyWeather.dayFourTemperatureMin))-\(String(weeklyWeather.dayFourTemperatureMax))"
                    self.weeklyWeatherDay4TempImageView.image = UIImage(named: "")
                    self.weeklyWeatherDay4TempImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                    
                    
// WEATHER DAY 5
                    
                    
                    self.weeklyWeatherDay5Temp.text = "\(String(weeklyWeather.dayFiveTemperatureMin))-\(String(weeklyWeather.dayFiveTemperatureMax))"
                    self.weeklyWeatherDay5TempImageView.image = UIImage(named: "")
                    self.weeklyWeatherDay5TempImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                    
                    
// WEATHER DAY 6
                    
                    self.weeklyWeatherDay6Temp.text = "\(String(weeklyWeather.daySixTemperatureMin))-\(String(weeklyWeather.daySixTemperatureMax))"
                    self.weeklyWeatherDay6TempImageView.image = UIImage(named: "")
                    self.weeklyWeatherDay6TempImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

                    
                    
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