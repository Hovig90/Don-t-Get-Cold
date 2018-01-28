//
//  ForecastViewModel.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/27/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    var dailyForecast: [DailyForecastViewModel] = []
    
    init(withForecast forecast: Forecast) {
        if let forecastList = forecast.list {
            for forecast in forecastList {
                if let dailyForecastViewModel = DailyForecastViewModel(withForecast: forecast) {
                    dailyForecast.append(dailyForecastViewModel)
                }
            }
        }
    }
}

struct DailyForecastViewModel {
    var forecastDate: String?
    var forecastImage: String?
    var forecastTempreture: String?
    
    init?(withForecast forecast: DailyForecast) {
        guard Date().compare(toDate: Date(withUNIXDate: Double(forecast.dt!)), withFormat: .regularDate) == false else {
            return nil
        }
        
        forecastDate = Date(withUNIXDate: Double(forecast.dt!)).convertDateToString(withFormatterStyle: .weekdayShort)
        forecastImage = WeatherIcon(rawValue: (nil, nil, forecast.weather!.first!.id!))?.get(.day)
        forecastTempreture = String(Int(forecast.temp!.day!))
    }
}
