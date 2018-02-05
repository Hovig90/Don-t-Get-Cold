//
//  UIView.swift
//  TicTacToe
//
//  Created by Hovig Kousherian on 11/24/16.
//  Copyright © 2016 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchorToAllSides(inView: UIView) {
        trailingAnchor.constraint(equalTo: inView.trailingAnchor).isActive = true
        leadingAnchor.constraint(equalTo: inView.leadingAnchor).isActive = true
        topAnchor.constraint(equalTo: inView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: inView.bottomAnchor).isActive = true
    }
    
    func name() -> String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    func layerShadow(withColor color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat?, path: CGPath?) {
        
        if let color = color {
            self.layer.shadowColor = color.cgColor
        }
        
        if let opacity = opacity {
            self.layer.shadowOpacity = opacity
        }
        
        if let offset = offset {
            self.layer.shadowOffset = offset
        }
        
        if let radius = radius {
            self.layer.shadowRadius = radius
        }
        
        if let path = path {
            self.layer.shadowPath = path
        }
    }
    
    func hideShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
    }
    
    func removeSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func captureScreen() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return snapshot
    }
    
    func addBlur(withStyle style: UIBlurEffectStyle) {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(blurEffectView)
            self.sendSubview(toBack: blurEffectView)
        } else {
            self.backgroundColor = .black
        }
    }
}
