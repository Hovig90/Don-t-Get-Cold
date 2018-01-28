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
        weatherIcon = WeatherIcon(rawValue: (nil, nil, weather.weather!.first!.id!))?.get(.day)
        weatherInfoData = [
            WeatherInfoViewModel(image: AppConstants.Images.SunriseIcon.rawValue, type: "Sunrise", value: sunrise),
            WeatherInfoViewModel(image: AppConstants.Images.SunsetIcon.rawValue, type: "Sunset", value: sunset),
            WeatherInfoViewModel(image: AppConstants.Images.CloudIcon.rawValue, type: "Cloudiness", value: String(weather.clouds!["all"]!) + " %"),
            WeatherInfoViewModel(image: AppConstants.Images.VisibilityDayIcon.rawValue, type: "Visibility", value: String(weather.visibility! / 1000) + " km"),
            WeatherInfoViewModel(image: AppConstants.Images.WindIcon.rawValue, type: "Wind", value: String(weather.wind!.speed!) + " mps"),
            WeatherInfoViewModel(image: AppConstants.Images.PressureIcon.rawValue, type: "Pressure", value: String(weather.main!.pressure!) + " hPa"),
            WeatherInfoViewModel(image: AppConstants.Images.HumidityIcon.rawValue, type: "Humidity", value: String(weather.main!.humidity!) + " %")
        ]
    }
}
