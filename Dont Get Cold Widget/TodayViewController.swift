//
//  TodayViewController.swift
//  Dont Get Cold Widget
//
//  Created by Hovig Kousherian on 3/16/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

//MARK: CLLocationManagerDelegate
extension TodayViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.first!) { (placemarks, error) in
            if let placemarks = placemarks, let placemark = placemarks.first, let locality = placemark.locality, let counrtyCode = placemark.isoCountryCode  {
            
                self.fetchWeatherData(forCity: locality + "," + counrtyCode)
            }
        }
    }
}

//MARK: NCWidgetProviding
extension TodayViewController : NCWidgetProviding {
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        if !LocationManager.locationStatusAllowed() {
            noDataLabel.isHidden = false
            self.tableView.isHidden = true
            completionHandler(NCUpdateResult.noData)
        }
        
        completionHandler(NCUpdateResult.newData)
    }
}

//MARK: UITableViewDataSource
extension TodayViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .WeatherTableViewCellIdentifier, for: indexPath) as! WeatherTableViewCell
        cell.backgroundImageViewContainerView.backgroundColor = UIColor.clear
        
        if let city = currentCity {
            cell.dataModel = city
        }
        cell.contentView.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

//MARK: UITableViewDelegate
extension TodayViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        extensionContext?.open(URL(string: AppConstants.extensionURLScheme)!, completionHandler: { (success) in
            if !success {
                fatalError("Crash: Couldn't launch app from widget.")
            }
        })
    }
}

class TodayViewController: UIViewController {
    
    //MARK: Members
    var currentCity: CurrentWeather? = {
        return CacheManager.cache.get(forKey: .currentCityTodayExtension) as? CurrentWeather
    }()
    
    //MARK: Outlets
    @IBOutlet weak var visiualEffectView: UIVisualEffectView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visiualEffectView.effect = UIVibrancyEffect.widgetPrimary()
        noDataLabel.isHidden = true
        
        tableView.register(UINib(nibName: .WeatherTableViewCell, bundle: nil), forCellReuseIdentifier: .WeatherTableViewCellIdentifier)
        
        LocationManager.shared.configure(withDelegate: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func noDataButtonTapped(_ sender: Any) {
        extensionContext?.open(URL(string: AppConstants.extensionURLSchemeEnableLocation)!, completionHandler: { (success) in
            if !success {
                fatalError("Crash: Couldn't launch app from widget.")
            }
        })
    }
    
    //MARK: Private
    private func fetchWeatherData(forCity currentCity: String) {
        DataManager.getCurrentWeatherData(withCityName: currentCity, cityID: nil) { (uid, weather, error) in
            guard error == nil, let weather = weather else {
                return
            }
            
            DispatchQueue.main.async {
                self.currentCity = CurrentWeather(withWeather: weather)
                self.currentCity?.cityTimeZone = TimeZone.current
                CacheManager.cache.set(self.currentCity!, forKey: .currentCityTodayExtension)
                if let currentCityCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? WeatherTableViewCell {
                    currentCityCell.dataModel = self.currentCity
                }
            }
        }
    }
}
 
