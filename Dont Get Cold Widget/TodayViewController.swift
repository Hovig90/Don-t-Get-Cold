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
                CacheManager.cache.replace(City(name: locality, country: counrtyCode, coord: Coordinate(withLongitude: Double((placemark.location?.coordinate.longitude)!), latitude: Double((placemark.location?.coordinate.latitude)!))), at: 0, forKey: .cities)
                self.fetchWeatherData(forCity: locality + "," + counrtyCode)
            }
        }
    }
}

//MARK: NCWidgetProviding
extension TodayViewController : NCWidgetProviding {
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}

extension TodayViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
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

extension TodayViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

class TodayViewController: UIViewController {
    
    //MARK: Members
    var currentCity: CurrentWeather?
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        
        LocationManager.shared.configure(withDelegate: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                self.tableView.reloadData()
            }
        }
    }
}
