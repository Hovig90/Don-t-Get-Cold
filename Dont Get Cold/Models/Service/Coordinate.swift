//
//  Coordinate.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 4/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class Coordinate: NSObject, ServiceObjectSerializable, NSCoding {
    
    var lon: Double?
    var lat: Double?
    
    init(withLongitude longitude: Double, latitude: Double) {
        self.lon = longitude
        self.lat = latitude
    }
    
    required init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.lon = representation[AppConstants.Encoding.lon.rawValue] as? Double
        self.lat = representation[AppConstants.Encoding.lat.rawValue] as? Double
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let lon = aDecoder.decodeDouble(forKey: .lon),
            let lat = aDecoder.decodeDouble(forKey: .lat) else {
                return nil
        }
        
        self.init(withLongitude: lon, latitude: lat)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.lon ?? 0, forKey: .lon)
        aCoder.encode(self.lat ?? 0, forKey: .lat)
    }
}
