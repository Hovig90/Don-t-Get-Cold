//
//  Forecast.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/25/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

struct CityServiceData: ServiceObjectSerializable {
    
    var id: Int?
    var name: String?
    var coord: Coordinate?
    var country: String?
    var population: Int?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.id = representation[AppConstants.Encoding.id.rawValue] as? Int
        self.name = representation[AppConstants.Encoding.name.rawValue] as? String
        self.coord = Coordinate(response: response, representation:representation[AppConstants.Encoding.coord.rawValue] as Any)
        self.country = representation[AppConstants.Encoding.country.rawValue] as? String
        self.population = representation[AppConstants.Encoding.population.rawValue] as? Int
    }
}

struct ForecastTempreture: ServiceObjectSerializable {
    var eve: Double?
    var day: Double?
    var min: Double?
    var max: Double?
    var morn: Double?
    var night: Double?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.eve = representation[AppConstants.Encoding.eve.rawValue] as? Double
        self.day = representation[AppConstants.Encoding.day.rawValue] as? Double
        self.min = representation[AppConstants.Encoding.min.rawValue] as? Double
        self.max = representation[AppConstants.Encoding.max.rawValue] as? Double
        self.night = representation[AppConstants.Encoding.night.rawValue] as? Double
        self.morn = representation[AppConstants.Encoding.morn.rawValue] as? Double
    }
}

struct DailyForecast: ServiceObjectSerializable {
    var dt: Int?
    var temp: ForecastTempreture?
    var pressure: Double?
    var humidity: Int?
    var weather: [WeatherData]?
    var speed: Double?
    var deg: Int?
    var clouds: Int?
    var snow: Double?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.dt = representation[AppConstants.Encoding.dt.rawValue] as? Int
        self.temp = ForecastTempreture(response: response, representation:representation[AppConstants.Encoding.temp.rawValue] as Any)
        self.pressure = representation[AppConstants.Encoding.pressure.rawValue] as? Double
        self.humidity = representation[AppConstants.Encoding.humidity.rawValue] as? Int
        self.weather = []
        for weather in representation[AppConstants.Encoding.weather.rawValue] as? [Any] ?? [] {
            if let weatherData = WeatherData(response: response, representation: weather) {
                self.weather?.append(weatherData)
            }
        }
        self.speed = representation[AppConstants.Encoding.speed.rawValue] as? Double
        self.deg = representation[AppConstants.Encoding.deg.rawValue] as? Int
        self.clouds = representation[AppConstants.Encoding.clouds.rawValue] as? Int
        self.snow = representation[AppConstants.Encoding.snow.rawValue] as? Double
    }
}

struct Forecast: ServiceObjectSerializable {
    var city: CityServiceData?
    var cod: Int?
    var message: Double?
    var cnt: Int?
    var list: [DailyForecast]?

    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.city = CityServiceData(response: response, representation: representation[AppConstants.Encoding.city.rawValue] as Any)
        self.cod = representation[AppConstants.Encoding.cod.rawValue] as? Int
        self.message = representation[AppConstants.Encoding.message.rawValue] as? Double
        self.cnt = representation[AppConstants.Encoding.cnt.rawValue] as? Int
        self.list = []
        for dailyTemp in representation[AppConstants.Encoding.list.rawValue] as? [Any] ?? [] {
            if let dailyTemp = DailyForecast(response: response, representation: dailyTemp) {
                self.list?.append(dailyTemp)
            }
        }
    }
}
