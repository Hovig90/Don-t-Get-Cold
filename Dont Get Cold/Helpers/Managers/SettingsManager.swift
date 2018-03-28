//
//  SettingsManager.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/11/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

enum MeasurementUnit: String {
    case metric
    case imperial
}

class SettingsManager {
    
    //MARK: Singleton
    static let shared = SettingsManager()
    
    private init() { }
    
    //MARK: Members
    private(set) var measurementUnit: MeasurementUnit {
        set {
            CacheManager.cache.set(newValue.rawValue as AnyObject, forKey: .measurementUnit)
        }
        get {
            if let unitString = CacheManager.cache.get(forKey: .measurementUnit) as? String, let unit = MeasurementUnit(rawValue: unitString) {
                return unit
            } else {
                CacheManager.cache.set(MeasurementUnit.metric.rawValue as AnyObject, forKey: .measurementUnit)
                return .metric
            }
        }
    }
    
    //MARK: Public
    func updateMeasurementUnit(with unit: MeasurementUnit) {
        self.measurementUnit = unit
    }
    
    func check(measurementUnit unit: MeasurementUnit) -> Bool {
        return self.measurementUnit == unit
    }
    
    func isFirstLocationRequest() -> Bool {
        guard CacheManager.cache.get(forKey: .locationRequestDone) != nil else {
            CacheManager.cache.set(true as AnyObject, forKey: .locationRequestDone)
            return true
        }
        
        return false
    }
}
