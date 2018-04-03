//
//  NSCoder+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/9/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

typealias Encoding = AppConstants.Encoding

extension NSCoder {
    func decodeInt(forKey key: Encoding) -> Int? {
        return Int(decodeInt32(forKey: key.rawValue))
    }
    
    func decodeDouble(forKey key: Encoding) -> Double? {
        return decodeDouble(forKey: key.rawValue)
    }
    
    func decodeBool(forKey key: Encoding) -> Bool? {
        return decodeBool(forKey: key.rawValue)
    }
    
    func decodeObject(forKey key: Encoding) -> Any? {
        return decodeObject(forKey: key.rawValue)
    }
    
    func encode(_ value: Int, forKey key: Encoding) {
        encode(value, forKey: key.rawValue)
    }
    
    func encode(_ value: Bool, forKey key: Encoding) {
        encode(value, forKey: key.rawValue)
    }
    
    func encode(_ value: Double, forKey key: Encoding) {
        encode(value, forKey: key.rawValue)
    }
    
    func encode(_ value: Any, forKey key: Encoding) {
        encode(value, forKey: key.rawValue)
    }
}
