//
//  AutocompleteItem.swift
//  WeatherApp
//
//  Created by Justin Wiggins on 8/3/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import Foundation

struct AutocompleteItem {
    
    var lat: String
    var lon: String
    var name: String
    
    init(items: NSArray, index: Int){
        
        lat = items[index]["lat"] as! String
        lon = items[index]["lon"] as! String
        name = items[index]["name"] as! String

        



        
        
    }
    
    
    
}



