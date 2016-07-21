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
    var lon = CLLocationDegrees()
    var lat = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        print(locationManager.location?.coordinate)
        
        
    }
    
    @IBAction func getMyLatAndLon(sender: AnyObject) {
        print(locationManager.location?.coordinate)
        lat = 39.680833
        lon = -86.1446394
        let key = "e492180da724ac1e28d7cd6846bb98c0"
        let url = "https://api.forecast.io/forecast/\(key)/\(lat),\(lon)"
        
        Alamofire.request(.GET, url)
            .responseJSON(completionHandler: { Response in
                if let data = Response.data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [ String : AnyObject]
                        print(json)
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