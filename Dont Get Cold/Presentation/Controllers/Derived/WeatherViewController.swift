//
//  WeatherViewController.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/21/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

extension WeatherViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(weatherInfoDataTableViewCellHeight)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WeatherInfoSectionHeaderTableViewCell") as? WeatherInfoSectionHeaderTableViewCell
        
        cell?.dataModel = self.weatherDataModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
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
        return CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
        cell.backgroundAlphaView.backgroundColor = UIColor(hex: 0x000000, alpha: indexPath.row % 2 == 0 ? 0.3 : 0.0 )
        
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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIButton!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UINib(nibName: "WeatherInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherInfoTableViewCell")
        tableView.register(UINib(nibName: "WeatherInfoSectionHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "WeatherInfoSectionHeaderTableViewCell")
        
        collectionView.register(UINib(nibName: "WeatherForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherForecastCollectionViewCell")
        
        DispatchQueue.global(qos: .default).async {
            DataManager.getForecastData(withCityName: self.weatherDataModel?.cityName, cityID: nil, andCount: 16) { (forecast, error) in
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
}
