//
//  UIScreen+extension.swift
//  TicTacToe
//
//  Created by Hovig Kousherian on 11/20/16.
//  Copyright © 2016 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UIScreen {
    
    static func width() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static func height() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func center() -> CGPoint {
        return CGPoint(x: width() / 2, y: height() / 2)
    }
}
