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
        standard.set(data, forKey: key.rawValue)
        standard.synchronize()
    }
    
    static func get(objectForKey key: AppConstants.CachingKey) -> AnyObject? {
        let data = standard.object(forKey: key.rawValue) as? Data
        if let data = data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
        }
        return nil
    }
    
    static func remove(objectForKey key: AppConstants.CachingKey) {
        standard.removeObject(forKey: key.rawValue)
    }
}
