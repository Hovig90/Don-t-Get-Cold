//
//  WeatherViewController.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/21/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

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
        return CGSize(width: 60, height: 100)
    }
    
    
}

extension WeatherViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForecastCollectionViewCell", for: indexPath) as! WeatherForecastCollectionViewCell
        
        if let dailyForecast = weatherForecastViewModel?.dailyForecast[indexPath.row] {
            cell.weatherForecastTopLabel.text = dailyForecast.forecastDate
            cell.weatherForecastImageView.image = UIImage(named: dailyForecast.forecastImage!)
            cell.weatherForecastBottomLabel.text = dailyForecast.forecastTempreture
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherForecastViewModel?.dailyForecast.count ?? 0
    }
}

class WeatherViewController: BaseViewController {

    //MARK: Members
    //var weatherForecastDataModel: ForecastTempreture
    var weatherDataModel: CurrentWeather?
    var weatherForecastViewModel: ForecastViewModel?
    var coordinates: Coordinate?
    
    let weatherInfoDataTableViewCellHeight = 50
    
    //MARK: Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
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
    
        updateView()
        tableViewHeightConstraint.constant = 0
        tableView.register(UINib(nibName: "WeatherInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoTableViewCell")
        collectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherForecastCollectionViewCell")
        self.tableViewHeightConstraint.constant = CGFloat(self.weatherInfoDataTableViewCellHeight * (self.weatherDataModel?.weatherInfoData.count)!)
        
        DispatchQueue.global(qos: .default).async {
            DataManager.getForecastData(withCityName: self.weatherDataModel?.cityName, cityID: nil, units: .metric, andCount: 16) { (forecast, error) in
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
    
    //MARK: Actions
    @IBAction func menuButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private
    private func updateView() {
        if let weatherData = weatherDataModel {
            self.cityLabel.text = weatherData.cityName
            self.weatherDescriptionLabel.text = weatherData.temperatureSummary
            self.dateTimeLabel.text = weatherData.date
            self.tempretureLabel.text = weatherData.temperature
            self.tempMaxLabel.text = weatherData.tempMax
            self.tempMinLabel.text = weatherData.tempMin
            if let icon = weatherData.weatherIcon {
                self.weatherImageView.image = UIImage(named: icon)
            }
            if let bgImage = weatherData.weatherBackgroundImage {
                self.backgroundImageView.image = UIImage(named: bgImage)
            }
        }
    }
}
