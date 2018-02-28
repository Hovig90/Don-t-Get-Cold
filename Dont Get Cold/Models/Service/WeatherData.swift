//
//  WeatherData.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/25/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

struct WeatherData: ServiceObjectSerializable {
    
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init?(response: HTTPURLResponse?, representation: Any) {
        guard let representation = representation as? [String : Any] else {
            return nil
        }
        
        self.id = representation[AppConstants.Encoding.id.rawValue] as? Int
        self.main = representation[AppConstants.Encoding.main.rawValue] as? String
        self.description = representation[AppConstants.Encoding.description.rawValue] as? String
        self.icon = representation[AppConstants.Encoding.description.rawValue] as? String
    }
}
