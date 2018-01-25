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
    static let BaseUrl = "http://api.openweathermap.org/data/2.5/"
    
    enum Encoding: String {
        case weather
        case forecast
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
        case sys
        case country
        case type
        case message
        case sunset
        case sunrise
    }
    
    enum Images: String {
        case ArrowUp
        case ArrowDown
        case CelsiusIcon
        case ClearSkyDayIcon
        case ClearSkyNightIcon
        case CloudIcon
        case FewCloudsDayIcon
        case FewCloudsNightIcon
        case HumidityIcon
        case MenuIcon
        case MistIcon
        case PressureIcon
        case RainDayIcon
        case RainNightIcon
        case SnowIcon
        case ThunderstormIcon
        case VisibilityDayIcon
        case VisibilityNightIcon
        case WindIcon
    }
}


