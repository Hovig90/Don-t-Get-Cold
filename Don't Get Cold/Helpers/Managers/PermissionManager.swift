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
        case Health
        case Motion
    }
    
    func requestPermission(permission: Permission, target: UIViewController, completion: ((Error?) -> Void)? = nil) {
        switch permission {
        case .Location:
            requestLocationPermission(target: target)
        case .Health:
            requestHealthPermission(target: target, completion: completion)
        case .Motion:
            requestMotionPermission(target: target)
            break
        }
    }
    
    //MARK: Private
    private func requestMotionPermission(target: UIViewController) {
        if !PedometerManager.isAuthorizedForRecording() {
            AlertManager().alert(with: "Location Permission", message: "The App Needs your Motion data.", target: target, action: "OK", handler: { (action) in
                self.openSettingsURL()
            })
        }
    }
    
    private func requestHealthPermission(target: UIViewController, completion: ((Error?) -> Void)? = nil) {
        switch HealthManager.health.authorizationStatus() {
        case .sharingAuthorized:
            if let completion = completion {
                completion(nil)
            }
            
            break
        case .sharingDenied,
             .notDetermined:
            
            HealthManager.health.requestPermission(completion: { (succes, error) in
                guard error == nil else {
                    AlertManager().alertCancel(with: "Error", message: error?.localizedDescription ?? "There was an error with health permission request.", target: target)
                    if let completion = completion {
                        completion(error)
                    }
                    return
                }
                if let completion = completion {
                    completion(nil)
                }
                
            })
        }
    }
    
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
