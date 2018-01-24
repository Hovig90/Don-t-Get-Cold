//
//  BaseModel.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/22/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

class BaseModel: Convertable {
    
    required init?(with jsonDictionary: [String : Any]) { }

    func toJSONDictionary() -> [String : Any] {
        return JSONDictionaryConverter.getJSONDicationaryFromObject(self)
    }
}
