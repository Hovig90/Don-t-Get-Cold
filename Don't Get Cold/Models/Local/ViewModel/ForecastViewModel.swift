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
                dailyForecast.append(DailyForecastViewModel(withForecast: forecast))
            }
        }
    }
}

struct DailyForecastViewModel {
    var forecastDate: String?
    var forecastImage: String?
    var forecastTempreture: String?
    
    init(withForecast forecast: DailyForecast) {
        forecastDate = Date(withUNIXDate: Double(forecast.dt!)).convertDateToString(withFormatterStyle: .weekdayShort)
        forecastTempreture = String(Int(forecast.temp!.eve!))
    }
}
