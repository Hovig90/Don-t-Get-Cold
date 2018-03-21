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
    static let forecastDailyUrl = BaseUrl + "forecast/daily"
    static let extensionURLScheme = "main-screen:"
    
    static let tableViewRefreshControl = 0o444
    static let tableViewActivityIndicatorView = 0o333
    
    enum Colors: Int {
        case AppGray = 0x6B6A6A
    }
    
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
        case population
        case min
        case max
        case eve
        case night
        case morn
        case day
        case snow
        case city
        case list
        case cnt
        
        //Local
        case backgroundImage
        case tempSummary
        case weatherInfo
        case date
        case timeZone
    }
    
    enum CachingKey: String {
        case cities
        case measurementUnit
        case currentCityTodayExtension
    }
    
    enum Images: String {
        case ArrowUp
        case ArrowDown
        case BrokenCloudsIcon
        case CelsiusIcon
        case ClearSkyDayIcon
        case ClearSkyNightIcon
        case CloudIcon
        case ColdThermometer
        case DrizzleThunderstormIcon
        case Fahrenheit
        case FewCloudsDayIcon
        case FewCloudsNightIcon
        case FogIcon
        case FreezingRainIcon
        case FreezingShowerIcon
        case HailIcon
        case HeavyRainIcon
        case HeavyShowerIcon
        case HeavySnowHailIcon
        case HotThermometer
        case HumidityIcon
        case MenuIcon
        case MistIcon
        case PressureIcon
        case RaggedThunderstormIcon
        case RainDayIcon
        case RainNightIcon
        case SandStormIcon
        case ShowerDayIcon
        case ShowerNightIcon
        case ShowerThunderstormIcon
        case SnowHailIcon
        case SnowIcon
        case StormIcon
        case SunsetIcon
        case SunriseIcon
        case ThunderstormIcon
        case VisibilityDayIcon
        case VisibilityNightIcon
        case WindIcon
    }
    
    enum BackgroundImages: String {
        case ClearDayBackground
        case ClearNightBackground
        
        case CloudyDayBackground
        case CloudyNightBackground
        
        case HeavySnowDayBackground
        case HeavySnowNightBackground
        
        case FewCloudsDayBackground
        case FewCloudsNightBackground
        
        case RainyDayBackground
        case RainyNightBackground
        
        case ThunderDayBackground
        case ThunderNightBackground
        
        case FoggyDayBackground
        case FoggyNightBackground
    }
    
    enum WeatherConditionCodes: Int {
        //source: http://openweathermap.org/weather-conditions
        //Thunder
        case ThunderLightRain = 200//.
        case ThunderRain = 201//.
        case ThunderHeavyRain = 202//.
        case LightThunder = 210//.
        case Thunder = 211//.
        case HeavyThunder = 212//.
        case RaggedThunder = 221//.
        case ThunderLightDrizzle = 230//.
        case ThunderDrizzle = 231//.
        case ThunderHeavyDrizzle = 232//.
        
        //Drizzle
        case LightDrizzle = 300//.
        case Drizzle = 301//.
        case HeavyDrizzle = 302//.
        case LightDrizzleRain = 310//.
        case DrizzleRain = 311//.
        case HeavyDrizzleRain = 312//.
        case ShowerRainDrizzle = 313//.
        case HeavyShowerRainDrizzle = 314//.
        case ShowerDrizzle = 321//.
        
        //Rain
        case LightRain = 500//.
        case Rain = 501//.
        case HeavyRain = 502//.
        case VeryHeavyRain = 503//.
        case ExtremeRain = 504//.
        case FreezingRain = 511//.
        case LightShowerRain = 520//.
        case ShowerRain = 521//.
        case HeavyShowerRain = 522//.
        case RaggedShowerRain = 531//.
        
        //Snow
        case LightSnow = 600//.
        case Snow = 601//.
        case HeavySnow = 602//.
        case Sleet = 611//.
        case ShowerSleet = 612//.
        case LightRainSnow = 615//.
        case RainSnow = 616//.
        case LightShowerSnow = 620//.
        case ShowerSnow = 621//.
        case HeavyShowerSnow = 622//.
        
        //Atmosphere
        case Mist = 701//.
        case Smoke = 711//.
        case Haze = 721//.
        case SandDust = 731//. -
        case Fog = 741//.
        case Sand = 751//. -
        case Dust = 761//. -
        case VolcanicAsh = 762//. -
        case Squalls = 771//. -
        case Tornado = 781//. -
        
        //Clear Sky
        case ClearSky = 800//.
        
        //Clouds
        case FewClouds = 801//.
        case ScatteredClouds = 802//.
        case BrokenClouds = 803//.
        case OvercastClouds = 804//.
        
        //Extreme
        case ExtremeTornado = 900//. -
        case TropicalStorm = 901//. -
        case ExtremeHurricane = 902//. -
        case ExtremeCold = 903//.
        case ExtremeHot = 904//. -
        case ExtremeWind = 905//.
        case ExtremeHail = 906//.
        
        //Extra
        case Calm = 951//. -
        case LightBreeze = 952//. -
        case GentleBreeze = 953//. -
        case ModerateBreeze = 954//. -
        case FreshBreeze = 955//. -
        case StrongBreeze = 956//. -
        case HighWind = 957//. -
        case Gale = 958//. -
        case SevereGale = 959//. -
        case Storm = 960//. -
        case ViolentStorm = 961//. -
        case Hurricane = 962//. -
    }
}


