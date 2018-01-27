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

extension WeatherViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            return
        }
        let diff = abs(scrollView.contentSize.height - scrollView.bounds.height) / (10 * 2)
        let alphaPercent = (abs(scrollView.contentOffset.y) / diff) * 0.1
        
        
        //self.weatherImageView.alpha = 1 - alphaPercent
    }
}

extension WeatherViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(weatherInfoDataTableViewCellHeight)
    }
}

extension WeatherViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoTableViewCell", for: indexPath) as! WeatherInfoTableViewCell
        
        let weatherData = self.weatherDataModel!.weatherInfoData[indexPath.row]
        cell.weatherInfoImageView.image = UIImage(named: weatherData.image!)
        cell.weatherInfoDataType.text = weatherData.type
        cell.weatherInfoDataValue.text = weatherData.value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDataModel?.weatherInfoData.count ?? 0
    }
}

extension WeatherViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
}

extension WeatherViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForecastCollectionViewCell", for: indexPath) as! WeatherForecastCollectionViewCell
        
        let dailyForecast = weatherForecastViewModel?.dailyForecast[indexPath.row]
        cell.weatherForecastTopLabel.text = dailyForecast?.forecastDate
        cell.weatherForecastImageView.image = UIImage(named: AppConstants.Images.FewCloudsDayIcon.rawValue)
        cell.weatherForecastBottomLabel.text = dailyForecast?.forecastTempreture
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherForecastViewModel?.dailyForecast.count ?? 0
    }
}

class WeatherViewController: UIViewController {

    //MARK: Members
    var citiess: [City] = []
    //var weatherForecastDataModel: ForecastTempreture
    var weatherDataModel: CurrentWeather? {
        didSet {
        
            self.cityLabel.text = weatherDataModel?.cityName
            self.weatherDescriptionLabel.text = weatherDataModel?.temperatureSummary
            self.dateTimeLabel.text = weatherDataModel?.date
            self.tempretureLabel.text = weatherDataModel?.temperature
            self.tempMaxLabel.text = weatherDataModel?.tempMax
            self.tempMinLabel.text = weatherDataModel?.tempMin
        }
    }
    var weatherForecastViewModel: ForecastViewModel?
    
    
    let weatherInfoDataTableViewCellHeight = 50
    
    //MARK: Outlets
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var tempretureUnitLabel: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        
        DataManager.getCities { (cities) in
            if let cities = cities {
                self.citiess = cities
            }
        }
        tableViewHeightConstraint.constant = 0
        tableView.register(UINib(nibName: "WeatherInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoTableViewCell")
        collectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherForecastCollectionViewCell")
        
        DataManager.getCurrentWeatherData(withCityName: "toronto", cityID: nil, units: .metric) { (weather, error) in
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.weatherDataModel = CurrentWeather(withWeather: weather!)
                self.tableView.reloadData()
                self.tableViewHeightConstraint.constant = CGFloat(self.weatherInfoDataTableViewCellHeight * (self.weatherDataModel?.weatherInfoData.count)!)
            }
            
            DispatchQueue.global(qos: .default).async {
                DataManager.getForecastData(withCityName: "toronto", cityID: nil, units: .metric, andCount: 6) { (forecast, error) in
                    guard error == nil else {
                        return
                    }
                    
                    if let forecast = forecast {
                        self.weatherForecastViewModel = ForecastViewModel(withForecast: forecast)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                    
                }
            }
            
            
        }
        
    PermissionManager.permission.requestPermission(permission: .Location, target: self) { (error) in
            
        }
        LocationManager.shared.configure(withDelegate: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Actions
    @IBAction func menuButtonTapped(_ sender: Any) {
        
    }
    
}
