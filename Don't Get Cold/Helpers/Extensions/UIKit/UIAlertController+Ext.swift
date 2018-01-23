//
//  UIAlertController+Ext.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/21/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func addActions(_ actions: [UIAlertAction]) {
        for action in actions {
            self.addAction(action)
        }
    }
}
