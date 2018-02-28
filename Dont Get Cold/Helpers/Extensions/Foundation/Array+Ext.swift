//
//  Array+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import Foundation

extension Array {
    mutating func replace(at index: Int, withElement element: Element) {
        if self.count > 0 {
            self.remove(at: index)
        }
        self.insert(element, at: index)
    }
}
