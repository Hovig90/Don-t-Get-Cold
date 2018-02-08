//
//  WeatherIcon.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/27/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

typealias WeatherIconTuple = (day: AppConstants.Images?, night: AppConstants.Images?, code: AppConstants.WeatherConditionCodes)

protocol WeatherImageProtocol {
    func get(_ type: WeatherIconType) -> String
}

enum WeatherIconType {
    case day
    case night
    case code
}

enum WeatherIcon: RawRepresentable, WeatherImageProtocol {
    
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
    case Fog
    case SandStorm
    case Storm
    case Hot
    case Cold
    case Windy
    case Hail
    
    var rawValue: WeatherIconTuple {
        switch self {
        case .ClearSky: return (.ClearSkyDayIcon, .ClearSkyNightIcon, .ClearSky)
        case .FewClouds: return (.FewCloudsDayIcon, .FewCloudsNightIcon, .FewClouds)
        case .Cloudy: return (.CloudIcon, .CloudIcon, .ScatteredClouds)
        case .BrokenClouds: return (.BrokenCloudsIcon, .BrokenCloudsIcon, .BrokenClouds)
        case .Thunderstorm: return (.ThunderstormIcon, .ThunderstormIcon, .LightThunder)
        case .RaggedThunderstorm: return (.RaggedThunderstormIcon, .RaggedThunderstormIcon, .RaggedThunder)
        case .DrizzleThunderstorm: return (.DrizzleThunderstormIcon, .DrizzleThunderstormIcon, .ThunderLightRain)
        case .ShowerThunderstorm: return (.ShowerThunderstormIcon, .ShowerThunderstormIcon, .ThunderRain)
        case .Rain: return (.RainDayIcon, .RainNightIcon, .LightDrizzle)
        case .ShowerRain: return (.ShowerDayIcon, .ShowerNightIcon, .ShowerRainDrizzle)
        case .HeavyRain: return (.HeavyRainIcon, .HeavyRainIcon, .HeavyDrizzle)
        case .HeavyShower: return (.HeavyShowerIcon, .HeavyShowerIcon, .HeavyShowerRainDrizzle)
        case .Snow: return (.SnowIcon, .SnowIcon, .LightSnow)
        case .FreezingRain: return (.FreezingRainIcon, .FreezingRainIcon, .FreezingRain)
        case .FreezingShower: return (.FreezingShowerIcon, .FreezingShowerIcon, .LightShowerRain)
        case .HeavySnowHail: return (.HeavySnowHailIcon, .HeavySnowHailIcon, .ShowerSleet)
        case .SnowHail: return (.SnowHailIcon, .SnowHailIcon, .Sleet)
        case .Mist: return (.MistIcon, .MistIcon, .Mist)
        case .Fog: return (.FogIcon, .FogIcon, .Smoke)
        case .SandStorm: return (.SandStormIcon, .SandStormIcon, .SandDust)
        case .Storm: return (.StormIcon, .StormIcon, .Squalls)
        case .Hot: return (.HotThermometer, .HotThermometer, .ExtremeHot)
        case .Cold: return (.ColdThermometer, .ColdThermometer, .ExtremeCold)
        case .Windy: return (.WindIcon, .WindIcon, .ExtremeWind)
        case .Hail: return (.HailIcon, .HailIcon, .ExtremeHail)
        }
    }
    
    init?(rawValue: WeatherIconTuple) {
        switch rawValue {
        case (_, _, .ClearSky), (_, _, .Calm), (_, _, .LightBreeze),
             (_, _, .GentleBreeze): self = .ClearSky
        case (_, _, .FewClouds): self = .FewClouds
        case (_, _, .ScatteredClouds): self = .Cloudy
        case (_, _, .BrokenClouds), (_, _, .OvercastClouds): self = .BrokenClouds
        case (_, _, .LightThunder), (_, _, .Thunder): self = .Thunderstorm
        case (_, _, .HeavyThunder), (_, _, .RaggedThunder): self = .RaggedThunderstorm
        case (_, _, .ThunderLightRain), (_, _, .ThunderLightDrizzle), (_, _, .ThunderDrizzle),
             (_, _, .ThunderHeavyDrizzle): self = .DrizzleThunderstorm
        case (_, _, .ThunderRain), (_, _, .ThunderHeavyRain): self = .ShowerThunderstorm
        case (_, _, .LightDrizzle), (_, _, .Drizzle), (_, _, .DrizzleRain),
             (_, _, .LightDrizzleRain), (_, _, .LightRain), (_, _, .Rain): self = .Rain
        case (_, _, .ShowerRainDrizzle), (_, _, .ShowerDrizzle), (_, _, .ExtremeRain),
             (_, _, .LightShowerRain), (_, _, .ShowerRain): self = .ShowerRain
        case (_, _, .HeavyDrizzle), (_, _, .HeavyDrizzleRain), (_, _, .HeavyRain),
             (_, _, .VeryHeavyRain): self = .HeavyRain
        case (_, _, .HeavyShowerRainDrizzle), (_, _, .HeavyShowerRain), (_, _, .RaggedShowerRain): self = .HeavyShower
        case (_, _, .LightSnow), (_, _, .Snow), (_, _, .HeavySnow): self = .Snow
        case (_, _, .FreezingRain), (_, _, .LightRainSnow), (_, _, .RainSnow): self = .FreezingRain
        case (_, _, .LightShowerSnow), (_, _, .ShowerSnow), (_, _, .HeavyShowerSnow): self = .FreezingShower
        case (_, _, .ShowerSleet): self = .HeavySnowHail
        case (_, _, .Sleet): self = .SnowHail
        case (_, _, .Mist): self = .Mist
        case (_, _, .Smoke), (_, _, .Haze), (_, _, .Fog): self = .Fog
        case (_, _, .SandDust), (_, _, .Sand), (_, _, .Dust),
             (_, _, .VolcanicAsh): self = .SandStorm
        case (_, _, .Squalls), (_, _, .Tornado), (_, _, .ExtremeTornado),
             (_, _, .TropicalStorm), (_, _, .ExtremeHurricane), (_, _, .HighWind),
             (_, _, .Gale), (_, _, .SevereGale), (_, _, .Storm),
             (_, _, .ViolentStorm), (_, _, .Hurricane): self = .Storm
        case (_, _, .ExtremeCold): self = .Cold
        case (_, _, .ExtremeHot): self = .Hot
        case (_, _, .ExtremeWind), (_, _, .ModerateBreeze), (_, _, .FreshBreeze),
             (_, _, .StrongBreeze): self = .Windy
        case (_, _, .ExtremeHail): self = .Hail
        }
    }
    
    func get(_ type: WeatherIconType) -> String {
        switch type {
        case .day: return self.rawValue.day!.rawValue
        case .night: return self.rawValue.night!.rawValue
        case .code: return String(self.rawValue.code.rawValue)
        }
    }
}

