//
//  UserDefaults+Ext.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/14/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import Foundation

typealias CachingKey = AppConstants.CachingKey

extension UserDefaults {
    
    static func save(object: AnyObject, forKey key: CachingKey) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        if let userDefaults = UserDefaults(suiteName: AppConstants.groupBundleIndentifier) {
            userDefaults.set(data, forKey: key)
        } else {
            standard.set(data, forKey: key)
        }
    }
    
    static func get(objectForKey key: CachingKey) -> AnyObject? {
        let data: Data?
        if let userDefaults = UserDefaults(suiteName: AppConstants.groupBundleIndentifier) {
            data = userDefaults.object(forKey: key) as? Data
        } else {
            data = standard.object(forKey: key) as? Data
        }
        
        if let data = data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
        }
        return nil
    }
    
    static func remove(objectForKey key: CachingKey) {
        if let userDefaults = UserDefaults(suiteName: AppConstants.groupBundleIndentifier) {
            userDefaults.removeObject(forKey: key)
        } else {
            standard.removeObject(forKey: key)
        }
    }
    
    static func convertPastDataToGourp(forKey key: String) {
        guard let userDefaults = UserDefaults(suiteName: AppConstants.groupBundleIndentifier),
        let standardUserDefaultData = standard.object(forKey: key) as? Data else {
            return
        }
        
        userDefaults.set(standardUserDefaultData, forKey: key)
        userDefaults.synchronize()
        standard.removeObject(forKey: key)
    }
}

extension UserDefaults {
    func set(_ value: Any?, forKey defaultName: CachingKey) {
        set(value, forKey: defaultName.rawValue)
        synchronize()
    }
    
    func object(forKey defaultName: CachingKey) -> Any? {
        return object(forKey: defaultName.rawValue)
    }
    
    func removeObject(forKey defaultName: CachingKey) {
        removeObject(forKey: defaultName.rawValue)
    }
}
