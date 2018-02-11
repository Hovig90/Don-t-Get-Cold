//
//  NSCoder+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/9/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

extension NSCoder {
    func decodeInt(forKey key: AppConstants.Encoding) -> Int? {
        return Int(decodeInt32(forKey: key.rawValue))
    }
    
    func decodeDouble(forKey key: AppConstants.Encoding) -> Double? {
        return decodeDouble(forKey: key.rawValue)
    }
    
    func decodeBool(forKey key: AppConstants.Encoding) -> Bool? {
        return decodeBool(forKey: key.rawValue)
    }
    
    func decodeObject(forKey key: AppConstants.Encoding) -> Any? {
        return decodeObject(forKey: key.rawValue)
    }
    
    func encode(_ value: Int, forKey key: AppConstants.Encoding) {
        encode(value, forKey: key.rawValue)
    }
    
    func encode(_ value: Bool, forKey key: AppConstants.Encoding) {
        encode(value, forKey: key.rawValue)
    }
    
    func encode(_ value: Double, forKey key: AppConstants.Encoding) {
        encode(value, forKey: key.rawValue)
    }
    
    func encode(_ value: Any, forKey key: AppConstants.Encoding) {
        encode(value, forKey: key.rawValue)
    }
}
