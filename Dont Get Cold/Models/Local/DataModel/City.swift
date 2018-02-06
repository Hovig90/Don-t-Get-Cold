//
//  City.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/23/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class City: NSObject, Convertable {

    let id: Int
    let name: String
    let country: String
    let coord: Coordinate
    
    required init?(with jsonDictionary: [String : Any]) {
        
        self.id = jsonDictionary[AppConstants.Encoding.id.rawValue] as! Int
        self.name = jsonDictionary[AppConstants.Encoding.name.rawValue] as! String
        self.country = jsonDictionary[AppConstants.Encoding.country.rawValue] as! String
        self.coord = Coordinate(response: nil, representation: jsonDictionary[AppConstants.Encoding.coord.rawValue] as Any)!
    }
    
    func toJSONDictionary() -> [String : Any] {
        return [:]
    }
}
