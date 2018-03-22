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
    
    func requestPermission(permission: Permission, target: UIViewController, completion: ((Bool, Error?) -> Void)? = nil) {
        switch permission {
        case .Location:
            requestLocationPermission(target: target, completion: completion)
            break
        }
    }
    
    //MARK: Private
    private func requestLocationPermission(target: UIViewController, completion: ((Bool, Error?) -> Void)? = nil) {
        switch LocationManager.authorizationStatus() {
        case .authorizedAlways,
             .authorizedWhenInUse:
            break
        case .denied,
             .restricted:
            AlertManager().alert(with: "Location Permission", message: "Your current location is needed to get an accurate weather information, and keep you up to date while you travel.", target: target, action: "OK", handler: { (action) in
                self.openSettingsURL(completionHandler: { (success) in
                    if let completion = completion {
                        completion(success, nil)
                    }
                })
            }, cancelHandler: { (action) in
                if let completion = completion {
                    completion(false, nil)
                }
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
