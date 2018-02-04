//
//  UIColor+Ext.swift
//  Emshi
//
//  Created by Hovig Kousherian on 9/14/16.
//  Copyright © 2016 HovanesKousherian. All rights reserved.
//

import UIKit

extension UIColor {
    //MARK: Hex Colors
    convenience init(red: Int, green: Int, blue: Int, alpha: Double = 1) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    convenience init(hex: Int, alpha: Double = 1) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, alpha: alpha)
    }
    
//    convenience init(hex: AppConstants.Colors) {
//        self.init(red:(hex.rawValue >> 16) & 0xff, green:(hex.rawValue >> 8) & 0xff, blue:hex.rawValue & 0xff)
//    }
    
    //MARK: Color Shades
    var darkerShade: UIColor {
        return colorShade(saturation: 0.2, brightness: 0.2)
    }
    
    var lighterShade: UIColor {
        return colorShade(saturation: 0.1, brightness: 0.1)
    }
    
    //MARK: Color Shades -- Private
    private func colorShade(saturation: CGFloat, brightness: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0
        var b: CGFloat = 0, a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a)
            else { return self }
        
        return UIColor(hue: h,
                       saturation: max(s - saturation, 0.0),
                       brightness: max(b - brightness, 0.0),
                       alpha: 1)
    }
}
