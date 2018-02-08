//
//  WeatherBackgroundImage.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/6/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

typealias WeatherBackgroundImageTuple = (day: AppConstants.BackgroundImages?, night: AppConstants.BackgroundImages?, code: Int)

extension WeatherBackgroundImage: WeatherImageProtocol {
    func get(_ type: WeatherIconType) -> String {
        switch type {
        case .day: return self.rawValue.day!.rawValue
        case .night: return self.rawValue.night!.rawValue
        case .code: return String(self.rawValue.code)
        }
    }
}

enum WeatherBackgroundImage: RawRepresentable {
    case ClearSky
    case Cloudy
    case ScateredClouds
    case Thunderstorm
    case Rain
    case Drizzle
    case Snow
    case HeavySnow
    case Hail
    case Mist
    case Fog
    case Storm
    case SandStorm
    case Tornado
    
    
    var rawValue: WeatherBackgroundImageTuple {
        switch self {
        case .ClearSky: return (.ClearDayBackground, .ClearNightBackground, 800)
        case .Cloudy: return (.CloudyNightBackground, .CloudyNightBackground, 802)
        case .HeavySnow: return (.HeavySnowDayBackground, .CloudyNightBackground, 612)
        default: return (.ClearDayBackground, .ClearNightBackground, 800)
            
        }
    }
    
    init?(rawValue: WeatherBackgroundImageTuple) {
        switch rawValue {
        case (_, _, 800): self = .ClearSky
        case (_, _, 802): self = .Cloudy
        default: self = .ClearSky
        }
    }
    
}
