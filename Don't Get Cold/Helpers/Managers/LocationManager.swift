//
//  LocationManager.swift
//  Emshi
//
//  Created by Hovig Kousherian on 2/10/17.
//  Copyright © 2017 Hovig Kousherian. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: CLLocationManager {
    
    //MARK: Members
    static let shared = LocationManager()
    
    //MARK: Overrides
    private override init() {
        super.init()

        self.pausesLocationUpdatesAutomatically = false
        self.distanceFilter = kCLDistanceFilterNone
        self.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func configure(withDelegate delegate: CLLocationManagerDelegate) {
        self.delegate = delegate
        self.startUpdatingLocation()
    }
    
}
