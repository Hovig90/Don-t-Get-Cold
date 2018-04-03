//
//  UINib+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 4/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UINib {
    convenience init(nibName name: AppConstants.NibNames, bundle bundleOrNil: Bundle?) {
        self.init(nibName: name.rawValue, bundle: bundleOrNil)
    }
}
