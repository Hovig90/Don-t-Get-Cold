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
        self.desiredAccuracy = kCLLocationAccuracyKilometer
        
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

extension LocationManager {
    func getTimeZone(_ uid: Int? = nil, forCity city: String, completion: @escaping ((Int?, TimeZone) -> Void)) {
        CLGeocoder().geocodeAddressString(city) { (pl, error) in
            guard error == nil, let timezone = pl?.first!.timeZone else {
                completion(uid, TimeZone.current)
                return
            }
            
            completion(uid, timezone)
        }
    }
}
