//
//  City.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/23/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class City: NSObject, Convertable, NSCoding {
    let id: Int
    let name: String
    let country: String
    let coord: Coordinate
    
    init(with id: Int = 0, name: String, country: String, coord: Coordinate) {
        self.id = id
        self.name = name
        self.country = country
        self.coord = coord
    }
    
    required init?(with jsonDictionary: [String : Any]) {
        self.id = jsonDictionary[AppConstants.Encoding.id.rawValue] as! Int
        self.name = jsonDictionary[AppConstants.Encoding.name.rawValue] as! String
        self.country = jsonDictionary[AppConstants.Encoding.country.rawValue] as! String
        self.coord = Coordinate(response: nil, representation: jsonDictionary[AppConstants.Encoding.coord.rawValue] as Any)!
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeInt(forKey: .id),
        let name = aDecoder.decodeObject(forKey: .name) as? String,
        let country = aDecoder.decodeObject(forKey: .country) as? String,
        let coord = aDecoder.decodeObject(forKey: .coord) as? Coordinate else {
            return nil
        }
        
        self.init(with: id, name: name, country: country, coord: coord)
    }
    
    override var description: String {
        get {
            return name + "," + country
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: .id)
        aCoder.encode(self.name, forKey: .name)
        aCoder.encode(self.country, forKey: .country)
        aCoder.encode(self.coord, forKey: .coord)
    }
    
    func toJSONDictionary() -> [String : Any] {
        return [:]
    }
}
