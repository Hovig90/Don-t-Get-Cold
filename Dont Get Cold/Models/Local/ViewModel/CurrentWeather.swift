//
//  CurrentWeather.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/24/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class CurrentWeather: NSObject, NSCoding {
    
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
    var cityTimeZone: TimeZone = TimeZone.current {
        willSet {
            self.updateDate(withTimeZone: newValue)
        }
    }
    var fullName: String {
        get {
            return self.cityName! + "," + (self.weather?.sys?.country)!
        }
    }
    
    override init() {
        super.init()
    }
    
    convenience init(withWeather weather: Weather) {
        self.init()
        
        self.weather = weather
        cityName = weather.name
        temperatureSummary = weather.weather?.first?.description
        
        temperature = stringFromDouble(weather.main?.temp)
        tempMin = stringFromDouble(weather.main?.temp)
        tempMax = stringFromDouble(weather.main?.temp)
        
        if let sys = weather.sys {
            if let sysSunrise = sys.sunrise {
                sunrise = Date(withUNIXDate: Double(sysSunrise)).convertDateToString(withFormatterStyle: .timeShort)
            }
            
            if let sysSunset = sys.sunset {
                sunset = Date(withUNIXDate: Double(sysSunset)).convertDateToString(withFormatterStyle: .timeShort)
            }
        }
        
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
    
    convenience init(cityName: String?, temperature: String?, weatherIcon: String?, weatherBackgroundImage: String?, tempMin: String?, tempMax: String?, temperatureSummary: String?) {
        self.init()
        
        self.cityName = cityName
        self.temperature = temperature
        self.weatherIcon = weatherIcon
        self.weatherBackgroundImage = weatherBackgroundImage
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.temperatureSummary = temperatureSummary
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let cityName = aDecoder.decodeObject(forKey: .city) as? String,
            let temperature = aDecoder.decodeObject(forKey: .temp) as? String,
            let weatherIcon = aDecoder.decodeObject(forKey: .icon) as? String,
            let weatherBackgroundImage = aDecoder.decodeObject(forKey: .backgroundImage) as? String,
            let tempMin = aDecoder.decodeObject(forKey: .temp_min) as? String,
            let tempMax = aDecoder.decodeObject(forKey: .temp_max) as? String,
            let temperatureSummary = aDecoder.decodeObject(forKey: .tempSummary) as? String else {
                return nil
        }
        
        self.init(cityName: cityName, temperature: temperature, weatherIcon: weatherIcon, weatherBackgroundImage: weatherBackgroundImage, tempMin: tempMin, tempMax: tempMax, temperatureSummary: temperatureSummary)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.cityName ?? "", forKey: .city)
        aCoder.encode(self.temperature ?? "", forKey: .temp)
        aCoder.encode(self.weatherIcon ?? "", forKey: .icon)
        aCoder.encode(self.weatherBackgroundImage ?? "", forKey: .backgroundImage)
        aCoder.encode(self.tempMin ?? "", forKey: .temp_min)
        aCoder.encode(self.tempMax ?? "", forKey: .temp_max)
        aCoder.encode(self.temperatureSummary ?? "", forKey: .tempSummary)
    }
    
    func updateData(_ data: Weather) {
        temperatureSummary = data.weather?.first?.description
        temperature = stringFromDouble(data.main?.temp)
        tempMin = stringFromDouble(data.main?.temp)
        tempMax = stringFromDouble(data.main?.temp)
        
        updateDate(withTimeZone: self.cityTimeZone)
        
        weatherInfoData.removeAll()
        if let sunrise = sunrise {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.SunriseIcon.rawValue, type: "Sunrise", value: sunrise))
        }
        
        if let sunset = sunset {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.SunsetIcon.rawValue, type: "Sunset", value: sunset))
        }
        
        if let clouds = data.clouds, let cloudiness = clouds["all"]  {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.CloudIcon.rawValue, type: "Cloudiness", value: String(cloudiness) + " %"))
        }
        
        if let visibility = data.visibility {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.VisibilityDayIcon.rawValue, type: "Visibility", value: String(visibility / 1000) + " km"))
        }
        
        if let wind = data.wind, let speed = wind.speed {
            weatherInfoData.append(WeatherInfoViewModel(image: AppConstants.Images.WindIcon.rawValue, type: "Wind", value: String(speed) + (SettingsManager.shared.check(measurementUnit: .metric) ? " mps" : " mph")))
        }
        
        if let main = data.main {
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
            if let weather = weather, let sys = weather.sys {
                if let sunrise = sys.sunrise {
                    self.sunrise = Date(withUNIXDate: Double(sunrise)).convertDateToString(withFormatterStyle: .timeShort, timeZone: timeZone)
                    self.weatherInfoData[0].value = self.sunrise
                }
                
                if let sunset = sys.sunset {
                    self.sunset = Date(withUNIXDate: Double(sunset)).convertDateToString(withFormatterStyle: .timeShort, timeZone: timeZone)
                    self.weatherInfoData[1].value = self.sunset
                }
                
                if let weatherInfo = weather.weather, let weatherId = weatherInfo.first?.id, let code = AppConstants.WeatherConditionCodes(rawValue: weatherId) {
                    weatherIcon = WeatherIcon(rawValue: (nil, nil, code))!.get(isNight(sunrise: sunrise!, sunset: sunset!, timeZone: timeZone) ? .night : .day)
                    weatherBackgroundImage = WeatherBackgroundImage(rawValue: (nil, nil, code))!.get(isNight(sunrise: sunrise!, sunset: sunset!, timeZone: timeZone) ? .night : .day)
                } else {
                    weatherIcon = WeatherIcon(rawValue: (nil, nil, .ClearSky))!.get(isNight(sunrise: sunrise!, sunset: sunset!, timeZone: timeZone) ? .night : .day)
                    weatherBackgroundImage = WeatherBackgroundImage(rawValue: (nil, nil, .ClearSky))!.get(isNight(sunrise: sunrise!, sunset: sunset!, timeZone: timeZone) ? .night : .day)
                }
            }
            self.date = Date().convertDateToString(withFormatterStyle: .weekdayShortWithDayAndTime, timeZone: timeZone)
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

    private func stringFromDouble(_ d: Double?) -> String {
        guard let doubleNumber = d else {
            return "--"
        }
        
        return String(Int(doubleNumber))
    }
}
