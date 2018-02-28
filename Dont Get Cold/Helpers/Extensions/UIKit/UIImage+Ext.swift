//
//  UIImage+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/11/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(named: AppConstants.Images) {
        self.init(named: named.rawValue)
    }
}
