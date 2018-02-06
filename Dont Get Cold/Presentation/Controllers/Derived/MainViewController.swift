//
//  MainViewController.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit
import CoreLocation

extension MainViewController: AddCityModalViewControllerDelegate {
    func update(withNewCity city: City) {
        requestWeatherData(forCity: city.name + "," + city.country)
    }
}

extension MainViewController: WeatherFooterTableViewCellDelegate {
    func openAddCityModelViewController() {
        if let addCityModalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCityModalViewController") as? AddCityModalViewController {
            addCityModalViewController.modalPresentationStyle = .overCurrentContext
            addCityModalViewController.cities = cities
            addCityModalViewController.delegate = self
            self.present(addCityModalViewController, animated: true, completion: nil)
        }
    }
}

extension MainViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.first!) { (placemarks, error) in
            if let placemarks = placemarks, let placemark = placemarks.first, let locality = placemark.locality, let counrtyCode = placemark.isoCountryCode  {
                self.requestWeatherData(forCity: locality + "," + counrtyCode, isCurrent: true)
            }
        }
    }
}

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
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        let weather = selectedCities[indexPath.row]
        cell.cityNameLabel.text = weather.cityName
        cell.subTitleLabel.text = weather.temperatureSummary
        cell.tempLabel.text = weather.temperature
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCities.count
    }
}

class MainViewController: BaseViewController {
    
    //MARK: Members
    var selectedCities: [CurrentWeather] =  []
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
        
        
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        tableView.register(UINib(nibName: "WeatherFooterTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "WeatherFooterTableViewCell")
        tableView.separatorStyle = .none
        
        PermissionManager.permission.requestPermission(permission: .Location, target: self) { (error) in
            
        }
        LocationManager.shared.configure(withDelegate: self)
        
    }
    
    //MARK: Private
    private func requestWeatherData(forCity city: String, isCurrent: Bool = false) {
        DataManager.getCurrentWeatherData(withCityName: city, cityID: nil, units: .metric) { (weather, error) in
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                isCurrent ? self.selectedCities.replace(at: 0, withElement: CurrentWeather(withWeather: weather!)) : self.selectedCities.append(CurrentWeather(withWeather: weather!))
                self.tableView.reloadData()
                
            }
        }
    }
}


