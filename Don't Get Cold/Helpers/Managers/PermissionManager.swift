//
//  PermissionManager.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/28/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import UIKit

class PermissionManager {
    
    static let permission = PermissionManager()
    
    private init() { }
    
    enum Permission {
        case Location
    }
    
    func requestPermission(permission: Permission, target: UIViewController, completion: ((Error?) -> Void)? = nil) {
        switch permission {
        case .Location:
            requestLocationPermission(target: target)
            break
        }
    }
    
    //MARK: Private
    private func requestLocationPermission(target: UIViewController) {
        switch LocationManager.authorizationStatus() {
        case .authorizedAlways,
             .authorizedWhenInUse:
            break
        case .denied,
             .restricted:
            AlertManager().alert(with: "Location Permission", message: "The App Needs your location.", target: target, action: "OK", handler: { (action) in
                self.openSettingsURL()
            })
        case .notDetermined:
            LocationManager.shared.requestWhenInUseAuthorization()
        }
    }
    
    private func openSettingsURL(completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: completion)
        } else {
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
        }
    }
}
