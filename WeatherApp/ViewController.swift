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

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let locationManager = CLLocationManager()
    private let apiKey = "e492180da724ac1e28d7cd6846bb98c0"
    var lon = CLLocationDegrees()
    var lat = CLLocationDegrees()
    var hourlyWeatherArray = [HourlyWeatherItem]()
    var weeklyWeatherArray = [WeeklyWeatherItem]()
    @IBOutlet weak var currentWeatherTemp: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
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
                    self.hourlyWeatherArray.removeAll()
                    self.weeklyWeatherArray.removeAll()
                    weatDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
                    let currentWeather = CurrentWeather(weatherDictionary: weatDictionary)
                    
                    
                    if let hourlyWeather = weatDictionary["hourly"]!["data"] as? NSArray {
                        for i in 0...(hourlyWeather.count - 1) {
                            let item = HourlyWeatherItem(hourlyWeather: hourlyWeather, index: i)
                            self.hourlyWeatherArray.append(item)
                        }
                    }
                    
                    
                    if let weeklyWeather = weatDictionary["daily"]!["data"] as? NSArray {
                        for i in 0...(weeklyWeather.count - 1) {
                            let item = WeeklyWeatherItem(weeklyWeather: weeklyWeather, index: i)
                            self.weeklyWeatherArray.append(item)
                        }
                    }
                    
                    print("Hourly Weather: ", self.hourlyWeatherArray)
                    print("Weekly Weather: ", self.weeklyWeatherArray)
                    
                    self.currentWeatherTemp.text = String(currentWeather.temperature)
                    self.currentWeatherTemp.alpha = 1.0
                    //self.currentWeatherImageView.image = UIImage(named: "")
                    
                    self.tableView.reloadData()
                } catch {
                    print("Error bitch")
                }
            }
        })
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WeeklyWeatherCell", forIndexPath: indexPath) as? WeeklyWeatherCell
        cell!.updateWithWeatherItem(weeklyWeatherArray[indexPath.row])
        return cell!
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