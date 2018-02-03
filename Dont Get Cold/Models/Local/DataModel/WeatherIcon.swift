//
//  WeatherIcon.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/27/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

typealias WeatherIconTuple = (day: AppConstants.Images?, night: AppConstants.Images?, code: Int)

enum WeatherIcon: RawRepresentable {
    enum WeatherIconType {
        case day
        case night
        case code
    }
    
    case ClearSky
    case Cloudy
    case FewClouds
    case BrokenClouds
    case Thunderstorm
    case RaggedThunderstorm
    case DrizzleThunderstorm
    case ShowerThunderstorm
    case Rain
    case ShowerRain
    case HeavyRain
    case HeavyShower
    case Snow
    case FreezingRain
    case FreezingShower
    case HeavySnowHail
    case SnowHail
    case Mist
    
    var rawValue: WeatherIconTuple {
        switch self {
        case .ClearSky: return (.ClearSkyDayIcon, .ClearSkyNightIcon, 800)
        case .FewClouds: return (.FewCloudsDayIcon, .FewCloudsNightIcon, 801)
        case .Cloudy: return (.CloudIcon, .CloudIcon, 802)
        case .BrokenClouds: return (.BrokenCloudsIcon, .BrokenCloudsIcon, 803)
        case .Thunderstorm: return (.ThunderstormIcon, .ThunderstormIcon, 210)
        case .RaggedThunderstorm: return (.RaggedThunderstormIcon, .RaggedThunderstormIcon, 210)
        case .DrizzleThunderstorm: return (.DrizzleThunderstormIcon, .DrizzleThunderstormIcon, 200)
        case .ShowerThunderstorm: return (.ShowerThunderstormIcon, .ShowerThunderstormIcon, 201)
        case .Rain: return (.RainDayIcon, .RainNightIcon, 300)
        case .ShowerRain: return (.ShowerDayIcon, .ShowerNightIcon, 313)
        case .HeavyRain: return (.HeavyRainIcon, .HeavyRainIcon, 302)
        case .HeavyShower: return (.HeavyShowerIcon, .HeavyShowerIcon, 314)
        case .Snow: return (.SnowIcon, .SnowIcon, 600)
        case .FreezingRain: return (.FreezingRainIcon, .FreezingRainIcon, 511)
        case .FreezingShower: return (.FreezingShowerIcon, .FreezingShowerIcon, 620)
        case .HeavySnowHail: return (.HeavySnowHailIcon, .HeavySnowHailIcon, 612)
        case .SnowHail: return (.SnowHailIcon, .SnowHailIcon, 611)
        case .Mist: return (.MistIcon, .MistIcon, 701)
        }
    }
    
    init?(rawValue: WeatherIconTuple) {
        switch rawValue {
        case (_, _, 800): self = .ClearSky
        case (_, _, 801): self = .FewClouds
        case (_, _, 802): self = .Cloudy
        case (_, _, 803), (_, _, 804): self = .BrokenClouds
        case (_, _, 210), (_, _, 211): self = .Thunderstorm
        case (_, _, 212), (_, _, 221): self = .RaggedThunderstorm
        case (_, _, 200), (_, _, 230), (_, _, 231), (_, _, 232): self = .DrizzleThunderstorm
        case (_, _, 201), (_, _, 202): self = .ShowerThunderstorm
        case (_, _, 300), (_, _, 301), (_, _, 310), (_, _, 500), (_, _, 501): self = .Rain
        case (_, _, 313), (_, _, 321), (_, _, 504), (_, _, 520), (_, _, 521): self = .ShowerRain
        case (_, _, 302), (_, _, 312), (_, _, 502), (_, _, 503): self = .HeavyRain
        case (_, _, 314), (_, _, 522), (_, _, 531): self = .HeavyShower
        case (_, _, 600), (_, _, 601), (_, _, 602): self = .Snow
        case (_, _, 511), (_, _, 615), (_, _, 616): self = .FreezingRain
        case (_, _, 620), (_, _, 621), (_, _, 622): self = .FreezingShower
        case (_, _, 612): self = .HeavySnowHail
        case (_, _, 611): self = .SnowHail
        case (_, _, 701): self = .Mist
        default: return nil
        }
    }
    
    func get(_ type: WeatherIconType) -> String {
        switch type {
        case .day: return self.rawValue.day!.rawValue
        case .night: return self.rawValue.night!.rawValue
        case .code: return String(self.rawValue.code)
        }
    }
}
