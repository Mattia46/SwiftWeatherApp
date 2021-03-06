//
//  Weather.swift
//  RespApiCall-weather
//
//  Created by Mattia on 17/12/2015.
//  Copyright © 2015 Mattia. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let temp: Int
    let description: String
    let icon: String
    
    var tempC: Int {
        get {
            return temp - 273
        }
    }
    
    init(cityName: String, temp: Int, description: String, icon: String) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
    }
}