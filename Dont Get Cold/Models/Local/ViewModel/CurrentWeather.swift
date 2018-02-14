//
//  CurrentWeather.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/24/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    var weather: Weather?
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
    var cityTimeZone: TimeZone? {
        willSet {
            self.updateDate(withTimeZone: newValue)
        }
    }
    
    init(withWeather weather: Weather) {
        self.weather = weather
        cityName = weather.name
        temperatureSummary = weather.weather?.first?.description
        temperature = String(Int(weather.main!.temp!))
        tempMin = String(Int(weather.main!.temp_min!))
        tempMax = String(Int(weather.main!.temp_max!))
        //date = Date(withUNIXDate: Double(weather.dt!)).convertDateToString(withFormatterStyle: .fullDay)
        sunrise = Date(withUNIXDate: Double(weather.sys!.sunrise!)).convertDateToString(withFormatterStyle: .timeShort)
        sunset = Date(withUNIXDate: Double(weather.sys!.sunset!)).convertDateToString(withFormatterStyle: .timeShort)
        
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
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.WindIcon.rawValue, type: "Wind", value: String(speed) + (SettingsManager.shared.check(measurementUnit: .metric) ? " mps" : " mph")))
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
    private func updateDate(withTimeZone timeZone: TimeZone?) {
        if let timeZone = timeZone {
            self.sunrise = Date(withUNIXDate: Double(weather!.sys!.sunrise!)).convertDateToString(withFormatterStyle: .timeShort, timeZone: timeZone)
            self.weatherInfoData[0].value = self.sunrise
            self.sunset = Date(withUNIXDate: Double(weather!.sys!.sunset!)).convertDateToString(withFormatterStyle: .timeShort, timeZone: timeZone)
            self.weatherInfoData[1].value = self.sunset
            self.date = Date(withUNIXDate: Double(weather!.dt!)).convertDateToString(withFormatterStyle: .fullDay, timeZone: timeZone)
            
            if let weatherId = weather!.weather?.first?.id, let code = AppConstants.WeatherConditionCodes(rawValue: weatherId) {
                weatherIcon = WeatherIcon(rawValue: (nil, nil, code))!.get(isNight(sunrise: sunrise!, sunset: sunset!, timeZone: timeZone) ? .night : .day)
                weatherBackgroundImage = WeatherBackgroundImage(rawValue: (nil, nil, code))!.get(isNight(sunrise: sunrise!, sunset: sunset!, timeZone: timeZone) ? .night : .day)
            }
        }
    }
    
    private func isNight(sunrise: String, sunset: String, timeZone: TimeZone? = nil) -> Bool {
        guard let sunrise = Double(sunrise.replacingOccurrences(of: ":", with: ".")),
            let sunset = Double(sunset.replacingOccurrences(of: ":", with: ".")),
            let currentTime = Double(Date().convertDateToString(withFormatterStyle: .timeShort, timeZone: timeZone ?? TimeZone.current)
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
