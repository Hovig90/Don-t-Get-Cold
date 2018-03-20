//
//  UserDefaults+Ext.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/14/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import Foundation

extension UserDefaults {

    
    static func save(object: AnyObject, forKey key: AppConstants.CachingKey) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        if let userDefaults = UserDefaults(suiteName: "group.com.hovigkousherian.Dont-Get-Cold") {
            userDefaults.set(data, forKey: key.rawValue)
            userDefaults.synchronize()
        } else {
            standard.set(data, forKey: key.rawValue)
            standard.synchronize()
        }
    }
    
    static func get(objectForKey key: AppConstants.CachingKey) -> AnyObject? {
        let data: Data?
        if let userDefaults = UserDefaults(suiteName: "group.com.hovigkousherian.Dont-Get-Cold") {
            data = userDefaults.object(forKey: key.rawValue) as? Data
        } else {
            data = standard.object(forKey: key.rawValue) as? Data
        }
        
        if let data = data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
        }
        return nil
    }
    
    static func remove(objectForKey key: AppConstants.CachingKey) {
        if let userDefaults = UserDefaults(suiteName: "com.hovigkousherian.Dont-Get-Cold") {
            userDefaults.removeObject(forKey: key.rawValue)
        } else {
            standard.removeObject(forKey: key.rawValue)
        }
    }
}
