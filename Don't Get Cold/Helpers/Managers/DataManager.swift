//
//  DataManager.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/21/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class DataManager {
    
    //MARK: Members
    static let BaseUrl = "http://api.openweathermap.org/data/2.5/weather"
    static let session = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    //MARK: Public
    static func getWeatherData(forLatitude lat: String, andLongitude lon: String) {
        
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: BaseUrl) {//lat=\(lat)&lon=\(lon)
            urlComponents.query = "APPID=\(AppConstants.WeatherApiKey)&q=toronto&units=metric"
            guard let url = urlComponents.url else { return }
            
            dataTask = session.dataTask(with: url, completionHandler: { (data, responce, error) in
                guard error == nil, let data = data?.convertToDictionary() else {
                    return
                }
                
                
                let weather = Weather(response: nil, representation: data)
                
            })
            dataTask?.resume()
        }
        
        
        
    }
    
    
}
