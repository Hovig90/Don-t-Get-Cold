//
//  AppConstants.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/21/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

struct AppConstants {
    
    static let WeatherApiKey = "bbcf61f77b09ced0996ff61969903587"
    
    enum Encoding: String {
        case weather
        case coord
        case lat
        case lon
        case base
        case visibility
        case wind
        case clouds
        case dt
        case id
        case name
        case cod
        case main
        case description
        case icon
        case temp
        case pressure
        case humidity
        case temp_min
        case temp_max
        case speed
        case deg
        case country
    }
}


