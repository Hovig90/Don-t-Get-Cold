//
//  WeatherBackgroundImage.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/6/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

typealias WeatherBackgroundImageTuple = (day: AppConstants.BackgroundImages?, night: AppConstants.BackgroundImages?, code: AppConstants.WeatherConditionCodes)

extension WeatherBackgroundImage: WeatherImageProtocol {
    func get(_ type: WeatherIconType) -> String {
        switch type {
        case .day: return self.rawValue.day!.rawValue
        case .night: return self.rawValue.night!.rawValue
        case .code: return String(self.rawValue.code.rawValue)
        }
    }
}

enum WeatherBackgroundImage: RawRepresentable {
    case ClearSky
    case FewClouds
    case Cloudy
    case Rain
    case Snow
    case Thunderstorm
    case Fog
    
    
    var rawValue: WeatherBackgroundImageTuple {
        switch self {
        case .ClearSky: return (.ClearDayBackground, .ClearNightBackground, .ClearSky)
        case .FewClouds: return (.FewCloudsDayBackground, .FewCloudsNightBackground, .FewClouds)
        case .Cloudy: return (.CloudyDayBackground, .CloudyNightBackground, .OvercastClouds)
        case .Snow: return (.HeavySnowDayBackground, .CloudyDayBackground, .Snow)
        case .Rain: return (.RainyDayBackground, .RainyNightBackground, .Rain)
        case .Thunderstorm: return (.ThunderDayBackground, .ThunderNightBackground, .Thunder)
        case .Fog: return (.FoggyDayBackground, .FoggyNightBackground, .Fog)
        }
    }
    
    init?(rawValue: WeatherBackgroundImageTuple) {
        switch rawValue {
        case (_, _, .ClearSky): self = .ClearSky
        case (_, _, .FewClouds), (_, _, .BrokenClouds): self = .FewClouds
        case (_, _, .ScatteredClouds), (_, _, .OvercastClouds), (_, _, .ExtremeCold),
             (_, _, .ExtremeWind): self = .Cloudy
        case (_, _, .LightDrizzle), (_, _, .Drizzle), (_, _, .HeavyDrizzle),
             (_, _, .LightDrizzleRain), (_, _, .DrizzleRain), (_, _, .HeavyDrizzleRain),
             (_, _, .ShowerRainDrizzle), (_, _, .HeavyShowerRainDrizzle), (_, _, .ShowerDrizzle),
             (_, _, .LightRain), (_, _, .Rain), (_, _, .HeavyRain),
             (_, _, .VeryHeavyRain), (_, _, .ExtremeRain), (_, _, .FreezingRain),
             (_, _, .LightShowerRain), (_, _, .ShowerRain), (_, _, .HeavyShowerRain),
             (_, _, .RaggedShowerRain), (_, _, .ExtremeHail): self = .Rain
        case (_, _, .LightSnow), (_, _, .Snow), (_, _, .HeavySnow),
             (_, _, .Sleet), (_, _, .ShowerSleet), (_, _, .LightRainSnow),
             (_, _, .RainSnow), (_, _, .LightShowerSnow), (_, _, .ShowerSnow),
             (_, _, .HeavyShowerSnow): self = .Snow
        case (_, _, .ThunderLightRain), (_, _, .ThunderRain), (_, _, .ThunderHeavyRain),
             (_, _, .LightThunder), (_, _, .Thunder), (_, _, .HeavyThunder),
             (_, _, .RaggedThunder), (_, _, .ThunderLightDrizzle), (_, _, .ThunderDrizzle),
             (_, _, .ThunderHeavyDrizzle): self = .Thunderstorm
        case (_, _, .Mist), (_, _, .Smoke), (_, _, .Haze),
             (_, _, .Fog): self = .Fog
        default: self = .ClearSky
        }
    }
    
}
