//
//  MainViewController.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: WeatherTableViewCellDelegate
extension MainViewController: WeatherTableViewCellDelegate {
    func deleteCell(_ cell: WeatherTableViewCell, completion: (() -> Void)) {
        let index = (tableView.indexPath(for: cell)?.row)!
        CacheManager.cache.remove(objectAt: index, forKey: .cities)
        self.selectedCities.remove(at: index)
        tableView.deleteRows(at: [tableView.indexPath(for: cell)!], with: .none)
        completion()
    }
}

//MARK: AddCityModalViewControllerDelegate
extension MainViewController: AddCityModalViewControllerDelegate {
    func update(withNewCity city: City) {
        CacheManager.cache.append(city, forKey: .cities)
        requestWeatherData(forCity: city.name + "," + city.country)
    }
}

//MARK: WeatherFooterTableViewCellDelegate
extension MainViewController: WeatherFooterTableViewCellDelegate {
    func openAddCityModelViewController() {
        if let addCityModalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCityModalViewController") as? AddCityModalViewController {
            addCityModalViewController.modalPresentationStyle = .overCurrentContext
            addCityModalViewController.cities = cities
            addCityModalViewController.delegate = self
            self.present(addCityModalViewController, animated: true, completion: nil)
        }
    }
    
    func reloadViewControllerWithUpdatedMeasurementUnit() {
        reloadViewController(withLoadedTimeZones: true)
    }
}

//MARK: CLLocationManagerDelegate
extension MainViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.first!) { (placemarks, error) in
            if let placemarks = placemarks, let placemark = placemarks.first, let locality = placemark.locality, let counrtyCode = placemark.isoCountryCode  {
                CacheManager.cache.replace(City(name: locality, country: counrtyCode, coord: Coordinate(withLongitude: Double((placemark.location?.coordinate.longitude)!), latitude: Double((placemark.location?.coordinate.latitude)!))), at: 0, forKey: .cities)
                self.requestWeatherData(forCity: locality + "," + counrtyCode, isCurrent: true)
            }
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in self.tableView.visibleCells {
            if let cell = cell as? WeatherTableViewCell {
                cell.parallaxForCell(onTableView: self.tableView, didScrollOnView: self.view)
            }
        }
    }
}

//MARK: UITableViewDelegate
extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let weatherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController {
            weatherViewController.weatherDataModel = selectedCities[indexPath.row]
            self.navigationController?.pushViewController(weatherViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WeatherFooterTableViewCell") as? WeatherFooterTableViewCell
        
        cell?.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

//MARK: UITableViewDataSource
extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        cell.dataModel = selectedCities[indexPath.row]
        cell.delegate = self
        cell.isDeletable = indexPath.row == 0 ? false : true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCities.count
    }
}

class MainViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    //MARK: Members
    var selectedCities: [CurrentWeather] =  []
    var timeZones: [TimeZone] = []
    var cities: [City] = []
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.getCities { (cities) in
            if let cities = cities {
                self.cities = cities
            }
        }

        reloadViewController(withLoadedTimeZones: false)
        
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        tableView.register(UINib(nibName: "WeatherFooterTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "WeatherFooterTableViewCell")
        tableView.separatorStyle = .none
        
        PermissionManager.permission.requestPermission(permission: .Location, target: self) { (error) in
            
        }
        LocationManager.shared.configure(withDelegate: self)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //MARK: Private
    fileprivate func reloadViewController(withLoadedTimeZones: Bool) {
        if let savedCities = CacheManager.cache.get(forKey: .cities) as? [City] {
            if withLoadedTimeZones {
                self.requestWeatherData(forSavedCities: savedCities, andTimesZones: self.timeZones)
            } else {
                DispatchQueue.global(qos: .default).async {
                    self.getTimeZones(forCities: savedCities, completion: { (timeZones) in
                        self.timeZones = timeZones
                        self.requestWeatherData(forSavedCities: savedCities, andTimesZones: timeZones)
                    })
                }
            }
        }
    }
    
    private func requestWeatherData(forSavedCities savedCities: [City], andTimesZones timeZones: [TimeZone]) {
        requestWeatherData(forCities: savedCities, completion: { (currentWeather) in
            DispatchQueue.main.async {
                self.selectedCities = currentWeather
                self.setTimesZones(timeZones, currentWeather: &self.selectedCities)
                self.tableView.reloadData()
            }
        })
    }
    
    private func requestWeatherData(forCity city: String, isCurrent: Bool = false) {
        DataManager.getCurrentWeatherData(withCityName: city, cityID: nil) { (uid, weather, error) in
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                if isCurrent {
                    self.selectedCities.replace(at: 0, withElement: CurrentWeather(withWeather: weather!))
                    self.tableView!.visibleCells.count > 0 ? self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none) : self.tableView.reloadData()
                } else {
                    DispatchQueue.global(qos: .default).async {
                        DispatchQueue.main.async {
                            LocationManager.shared.getTimeZone(forCity: city, completion: { (_, timeZone) in
                                let newCity = CurrentWeather(withWeather: weather!)
                                newCity.cityTimeZone = timeZone
                                self.timeZones.append(timeZone)
                                self.selectedCities.append(newCity)
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }
    }
    
    private func getTimeZones(forCities cities: [City], completion: @escaping (([TimeZone]) -> Void)) {
        var timeZoneArray = Array<Any>(repeating: 0, count: cities.count)
        
        for city in cities {
            LocationManager.shared.getTimeZone(cities.index(of: city), forCity: city.name + "," + city.country) { (uid, timeZone) in
                guard let uid = uid else { return }
                
                timeZoneArray.replace(at: uid, withElement: timeZone)
                if timeZoneArray.count == cities.count {
                    if let timeZoneArray = timeZoneArray as? [TimeZone] {
                        completion(timeZoneArray)
                    }
                }
            }
        }
    }
    
    private func requestWeatherData(forCities cities: [City], completion: @escaping (([CurrentWeather]) -> Void)) {
        var weatherResultArray = Array<Any>(repeating: 0, count: cities.count)
        
        for city in cities {
            DataManager.getCurrentWeatherData(cities.index(of: city), withCityName: city.name + "," + city.country, cityID: nil) { (uid, weather, error) in
                guard error == nil, let uid = uid else { return }
                
                weatherResultArray.replace(at: uid, withElement: CurrentWeather(withWeather: weather!))
                DispatchQueue.main.async {
                    if weatherResultArray.count == cities.count {
                        if let weatherResultArray = weatherResultArray as? [CurrentWeather] {
                            completion(weatherResultArray)
                        }
                    }
                }
            }
        }
    }
    
    private func setTimesZones(_ timeZones: [TimeZone], currentWeather: inout [CurrentWeather]) {
        if timeZones.count == currentWeather.count {
            for i in 0..<currentWeather.count {
                currentWeather[i].cityTimeZone = timeZones[i]
            }
        }
    }
}


