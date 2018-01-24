//
//  WeatherViewController.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/21/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit
import CoreLocation

extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}

class WeatherViewController: UIViewController {

    //MARK: Members
    var citiess: [City] = []
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        
        DataManager.getCities { (cities) in
            if let cities = cities {
                self.citiess = cities
            }
        }
    
        DataManager.getCurrentWeatherData(withCityName: "toronto", cityID: nil, units: .metric) { (weather, error) in
            guard error == nil else {
                return
            }
            
            
        }
        PermissionManager.permission.requestPermission(permission: .Location, target: self) { (error) in
            
        }
        LocationManager.shared.configure(withDelegate: self)
    }
}
