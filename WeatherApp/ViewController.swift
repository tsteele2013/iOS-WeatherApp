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
    @IBOutlet weak var scrollView: UIScrollView!
    
    
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
                        var counter = 0
                        for item in self.hourlyWeatherArray {
                            let hrlyView = createHourlySubview(item)
                            hrlyView.layer.borderWidth = 2
                            hrlyView.layer.borderColor = UIColor.blueColor().CGColor
                            hrlyView.center.x = CGFloat(65 * counter + 50)
                            self.scrollView.addSubview(hrlyView)
                            self.scrollView.contentSize.width = CGFloat(65 * counter + 100)
                            
                            counter += 1
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
                    self.currentWeatherImageView.image = UIImage(named: "SunFilled")
                    
                    self.tableView.reloadData()
                } catch {
                    print("Error bitch")
                }
            }
        })
        
        let url2 = "https://autocomplete.wunderground.com/aq?query=New%20Pa&c=US"
        var autocomplete = NSDictionary()
        Alamofire.request(.GET, url2).responseJSON(completionHandler: { Response in
            if let data = Response.data{
                do{
                    autocomplete = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
                 
                    let arr = autocomplete["RESULTS"] as! NSArray
                    for item in 0...(arr.count - 1){
                        let acItem = AutocompleteItem(items: arr, index: item)
                        print(acItem)
                    }
                }
                catch{
                    print("cunt")
                }
            }
        })
        
    }
}


func createHourlySubview(item: HourlyWeatherItem) -> UIView {
    let view = UIView()
    view.frame = CGRect(x: 0, y: 0, width: 55, height: 75)
    let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 55, height: 20))
    tempLabel.textAlignment = .Center
    tempLabel.text = String(item.temperature)
    
    let timeLabel = UILabel(frame: CGRect(x: 0, y: 55, width: 55, height: 20))
    timeLabel.textAlignment = .Center
    timeLabel.text = String(item.hourlyTime!)
    timeLabel.adjustsFontSizeToFitWidth = true
    
    let wthrIcon = UIImageView(frame: CGRect(x: 10, y: 20, width: 35, height: 35))
    wthrIcon.image = UIImage(named: "SunFilled")
    view.addSubview(tempLabel)
    view.addSubview(timeLabel)
    view.addSubview(wthrIcon)
    return view
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