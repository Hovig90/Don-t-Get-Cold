//
//  Weather.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/21/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation
import CoreLocation

class Coordinate: NSObject, ServiceObjectSerializable, NSCoding {
    
    var lon: Double?
    var lat: Double?
    
    init(withLongitude longitude: Double, latitude: Double) {
        self.lon = longitude
        self.lat = latitude
    }
    
    required init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.lon = representation[AppConstants.Encoding.lon.rawValue] as? Double
        self.lat = representation[AppConstants.Encoding.lat.rawValue] as? Double
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let lon = aDecoder.decodeDouble(forKey: .lon),
            let lat = aDecoder.decodeDouble(forKey: .lat) else {
              return nil
        }
        
        self.init(withLongitude: lon, latitude: lat)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.lon ?? 0, forKey: .lon)
        aCoder.encode(self.lat ?? 0, forKey: .lat)
    }
}

struct Tempreture: ServiceObjectSerializable {
    var temp: Double?
    var pressure: Int?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.temp = representation[AppConstants.Encoding.temp.rawValue] as? Double
        self.pressure = representation[AppConstants.Encoding.pressure.rawValue] as? Int
        self.humidity = representation[AppConstants.Encoding.humidity.rawValue] as? Double
        self.temp_min = representation[AppConstants.Encoding.temp_min.rawValue] as? Double
        self.temp_max = representation[AppConstants.Encoding.temp_max.rawValue] as? Double
    }
}

struct Wind: ServiceObjectSerializable {
    var speed: Double?
    var deg: Double?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.speed = representation[AppConstants.Encoding.speed.rawValue] as? Double
        self.deg = representation[AppConstants.Encoding.deg.rawValue] as? Double
    }
}

struct SystemData: ServiceObjectSerializable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.type = representation[AppConstants.Encoding.type.rawValue] as? Int
        self.id = representation[AppConstants.Encoding.id.rawValue] as? Int
        self.message = representation[AppConstants.Encoding.message.rawValue] as? Double
        self.country = representation[AppConstants.Encoding.country.rawValue] as? String
        self.sunrise = representation[AppConstants.Encoding.sunrise.rawValue] as? Int
        self.sunset = representation[AppConstants.Encoding.sunset.rawValue] as? Int
    }
}

struct Weather: ServiceObjectSerializable {
    
    var coord: Coordinate?
    var weather: [WeatherData]?
    var base: String?
    var main: Tempreture?
    var visibility: Double?
    var wind: Wind?
    var clouds: [String : Int]?
    var dt: Int?
    var id: Int?
    var name: String?
    var cod: Int?
    var sys: SystemData?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.coord = Coordinate(response: response, representation: representation[AppConstants.Encoding.coord.rawValue] as Any)
        self.weather = []
        for weather in representation[AppConstants.Encoding.weather.rawValue] as? [Any] ?? [] {
            if let weatherData = WeatherData(response: response, representation: weather) {
                self.weather?.append(weatherData)
            }
        }
        
        self.base = representation[AppConstants.Encoding.base.rawValue] as? String
        self.main = Tempreture(response: response, representation: representation[AppConstants.Encoding.main.rawValue] as Any)
        self.visibility = representation[AppConstants.Encoding.visibility.rawValue] as? Double
        self.wind = Wind(response: response, representation: representation[AppConstants.Encoding.wind.rawValue] as Any)
        self.clouds = representation[AppConstants.Encoding.clouds.rawValue] as? [String : Int]
        self.dt = representation[AppConstants.Encoding.dt.rawValue] as? Int
        self.id = representation[AppConstants.Encoding.id.rawValue] as? Int
        self.name = representation[AppConstants.Encoding.name.rawValue] as? String
        self.cod = representation[AppConstants.Encoding.cod.rawValue] as? Int
        self.sys = SystemData(response: response, representation: representation[AppConstants.Encoding.sys.rawValue] as Any)
    }
}
