//
//  CacheManager.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/11/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import Foundation

class CacheManager {
    
    static let cache = CacheManager()
    
    private init() { }
    
    func set(_ obj: AnyObject, forKey key: CachingKey) {
        UserDefaults.save(object: obj, forKey: key)
    }
    
    func get(forKey key:CachingKey) -> AnyObject? {
        return UserDefaults.get(objectForKey: key)
    }
    
    func remove(forKey key: CachingKey) {
        UserDefaults.remove(objectForKey: key)
    }
    
    func append(_ obj: AnyObject, forKey key: CachingKey) {
        if var cachedArray = get(forKey: key) as? [AnyObject] {
            cachedArray.append(obj)
            set(cachedArray as AnyObject, forKey: key)
        } else {
            print("Caching: The requested array object with the key '\(key.rawValue)' has not been cached yet, the app will attempt to save the object.")
            set([obj] as AnyObject, forKey: key)
        }
    }
    
    func insert(_ obj: AnyObject, at index: Int, forKey key: CachingKey) {
        if var cachedArray = get(forKey: key) as? [AnyObject] {
            cachedArray.insert(obj, at: index)
            set(cachedArray as AnyObject, forKey: key)
        } else {
            print("Caching: The requested array object with the key '\(key.rawValue)' has not been cached yet, the app will attempt to save the object.")
            set([obj] as AnyObject, forKey: key)
        }
    }
    
    func replace(_ obj: AnyObject, at index: Int, forKey key: CachingKey) {
        if var cachedArray = get(forKey: key) as? [AnyObject] {
            cachedArray.replace(at: index, withElement: obj)
            set(cachedArray as AnyObject, forKey: key)
        } else {
            print("Caching: The requested array object with the key '\(key.rawValue)' has not been cached yet, the app will attempt to save the object.")
            set([obj] as AnyObject, forKey: key)
        }
    }
    
    func remove(objectAt index: Int, forKey key: CachingKey) {
        if var cachedArray = get(forKey: key) as? [AnyObject] {
            cachedArray.remove(at: index)
            set(cachedArray as AnyObject, forKey: key)
        } else {
            print("Caching: Attempted to remove an object from cached array with the key '\(key.rawValue)' that has not been cached yet.")
        }
    }
    
    func contains(_ obj: AnyObject, forKey key: CachingKey) -> Bool {
        if let cachedArray = get(forKey: key) as? [AnyObject] {
            return cachedArray.contains {
                return $0.description.isEqual(obj.description)
            }
        } else {
            print("Caching: The requested array object with the key '\(key.rawValue)' has not been cached yet.")
            return false
        }
    }
    
    func convertPastDataToGourp() {
        for cachedDataType in AppConstants.CachingKey.allValues {
            UserDefaults.convertPastDataToGourp(forKey: cachedDataType)
        }
    }
}
