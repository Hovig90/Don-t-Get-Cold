//
//  Data+Ext.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/22/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

extension Data {
    func convertToDictionary() -> [String : Any]? {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
            return jsonDictionary
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func convertToArrayOfDictionaries() -> [[String : Any]]? {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: self, options: []) as? [[String: Any]]
            return jsonDictionary
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
