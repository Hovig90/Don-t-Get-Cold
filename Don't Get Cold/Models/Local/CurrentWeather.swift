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
    var weatherInfoData: [WeatherInfoDataModel] = []
    var date: String?
    
    init(withWeather weather: Weather) {
        cityName = weather.name
        temperatureSummary = weather.weather?.first?.description
        temperature = String(Int(weather.main!.temp!))
        tempMin = String(Int(weather.main!.temp_min!))
        tempMax = String(Int(weather.main!.temp_max!))
        date = Date(withUNIXDate: Double(weather.dt!)).convertDateToString(withFormatterStyle: .fullDay)
        weatherInfoData = [
            WeatherInfoDataModel(image: AppConstants.Images.CloudIcon.rawValue, type: "Cloudiness", value: String(weather.clouds!["all"]!) + " %"),
            WeatherInfoDataModel(image: AppConstants.Images.VisibilityDayIcon.rawValue, type: "Visibility", value: String(weather.visibility! / 1000) + " km"),
            WeatherInfoDataModel(image: AppConstants.Images.WindIcon.rawValue, type: "Wind", value: String(weather.wind!.speed!) + " mps"),
            WeatherInfoDataModel(image: AppConstants.Images.PressureIcon.rawValue, type: "Pressure", value: String(weather.main!.pressure!) + " hPa"),
            WeatherInfoDataModel(image: AppConstants.Images.HumidityIcon.rawValue, type: "Humidity", value: String(weather.main!.humidity!) + " %")
        ]
    }
    
    //MARK: Private
    private func getWeatherIcon(withCode code: Int) -> String {
        
        return ""
    }
}
