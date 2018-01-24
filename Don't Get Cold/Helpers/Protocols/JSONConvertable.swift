//
//  JSONConvertable.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/22/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

protocol Convertable {
    func toJSONDictionary() -> [String : Any]
}

protocol ServiceObjectSerializable/*: Convertable*/ {
    init?(response: HTTPURLResponse?, representation: Any)
}

struct JSONConvertable {
    static func convert(_ obj: Any, toDictionary dict: inout [String : Any]) {
        let mirror = Mirror(reflecting: obj)
        
        for attribute in mirror.children {
            JSONConvertable.extractMirroredValues(attribute, &dict)
        }
        
        if let ancestor = mirror.superclassMirror {
            for decendent in ancestor.children {
                JSONConvertable.extractMirroredValues(decendent, &dict)
            }
        }
    }
    
    static func extractMirroredValues(_ attr: Mirror.Child, _ dict: inout [String : Any]) {
        if let label = attr.label {
            if let value = attr.value as? String {
                dict[label] = value
            } else if let value = attr.value as? Int {
                dict[label] = value
            } else if let value = attr.value as? Double {
                dict[label] = value
            } else if let value = attr.value as? Bool {
                dict[label] = value
            }
        }
    }
}

struct JSONDictionaryConverter {
    static func getJSONDicationaryFromObject(_ obj: Convertable) -> [String : Any] {
        var dict =  [String : Any]()
        
        JSONConvertable.convert(obj, toDictionary: &dict)
        
        return dict
    }
}
