//
//  CurrentWeather.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/24/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    var cityName: String?
    var temperature: String?
    var weatherIcon: String?
    var weatherBackgroundImage: String?
    var tempMin: String?
    var tempMax: String?
    var temperatureSummary: String?
    var weatherInfoData: [WeatherInfoViewModel] = []
    var date: String?
    var sunrise: String?
    var sunset: String?
    
    init(withWeather weather: Weather) {
        cityName = weather.name
        temperatureSummary = weather.weather?.first?.description
        temperature = String(Int(weather.main!.temp!))
        tempMin = String(Int(weather.main!.temp_min!))
        tempMax = String(Int(weather.main!.temp_max!))
        date = Date(withUNIXDate: Double(weather.dt!)).convertDateToString(withFormatterStyle: .fullDay)
        sunrise = Date(withUNIXDate: Double(weather.sys!.sunrise!)).convertDateToString(withFormatterStyle: .timeShort)
        sunset = Date(withUNIXDate: Double(weather.sys!.sunset!)).convertDateToString(withFormatterStyle: .timeShort)
        
        
        if let weatherId = weather.weather?.first?.id, let code = AppConstants.WeatherConditionCodes(rawValue: weatherId) {
            weatherIcon = WeatherIcon(rawValue: (nil, nil, code))!.get(isNight(sunrise: sunrise!, sunset: sunset!) ? .night : .day)
        }
        
        
        weatherBackgroundImage = WeatherBackgroundImage(rawValue: (nil, nil, (weather.weather?.first?.id!)!))!.get(.night)
        weatherBackgroundImage = WeatherBackgroundImage(rawValue: (nil, nil, (weather.weather?.first?.id!)!))!.get(.day)
        
        
        if let sunrise = sunrise {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.SunriseIcon.rawValue, type: "Sunrise", value: sunrise))
        }
        if let sunset = sunset {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.SunsetIcon.rawValue, type: "Sunset", value: sunset))
        }
        if let clouds = weather.clouds, let cloudiness = clouds["all"]  {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.CloudIcon.rawValue, type: "Cloudiness", value: String(cloudiness) + " %"))
        }
        if let visibility = weather.visibility {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.VisibilityDayIcon.rawValue, type: "Visibility", value: String(visibility / 1000) + " km"))
        }
        if let wind = weather.wind, let speed = wind.speed {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.WindIcon.rawValue, type: "Wind", value: String(speed) + " mps"))
        }
        if let main = weather.main {
            if let pressure = main.pressure {
                weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.PressureIcon.rawValue, type: "Pressure", value: String(pressure) + " hPa"))
            }
            if let humidity = main.humidity {
                weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.HumidityIcon.rawValue, type: "Humidity", value: String(humidity) + " %"))
            }
        }
    }
    
    //Mark: Private
    private func isNight(sunrise: String, sunset: String) -> Bool {
        guard let sunrise = Double(sunrise.replacingOccurrences(of: ":", with: ".")),
            let sunset = Double(sunset.replacingOccurrences(of: ":", with: ".")),
            let currentTime = Double(Date().convertDateToString(withFormatterStyle: .timeShort)
                .replacingOccurrences(of: ":", with: ".")) else {
                    fatalError("time passed is not in the correct format.")
        }
        
        if currentTime >= sunrise && currentTime < sunset {
            return false
        } else {
            return true
        }
    }
}
