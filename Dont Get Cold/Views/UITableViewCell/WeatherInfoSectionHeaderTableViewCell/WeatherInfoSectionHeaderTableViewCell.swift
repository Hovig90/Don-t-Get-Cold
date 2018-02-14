//
//  WeatherInfoSectionHeaderTableViewCell.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/11/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class WeatherInfoSectionHeaderTableViewCell: UITableViewHeaderFooterView {

    //MARK: Members
    var dataModel: CurrentWeather? {
        didSet {
            updateView()
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tempretureUnitIconImageView: UIImageView!
    @IBOutlet weak var tempMaxUnitIconImageView: UIImageView!
    @IBOutlet weak var tempMinUnitIconImageView: UIImageView!
    @IBOutlet weak var arrowUpImageView: UIImageView!
    @IBOutlet weak var arrowDownImageView: UIImageView!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor(hex: 0x333333)
        self.weatherImageView.cornerRadius(15)
        self.containerView.regularShadow()
        self.cityLabel.regularShadow()
        self.weatherDescriptionLabel.regularShadow()
        self.dateTimeLabel.regularShadow()
        self.tempretureLabel.regularShadow()
        self.tempMaxLabel.regularShadow()
        self.tempMinLabel.regularShadow()
        self.weatherIconImageView.regularShadow()
        self.tempretureUnitIconImageView.regularShadow()
        self.tempMaxUnitIconImageView.regularShadow()
        self.tempMinUnitIconImageView.regularShadow()
        self.arrowUpImageView.regularShadow()
        self.arrowDownImageView.regularShadow()
    }
    
    //MARK: Private
    private func updateView() {
        if let weatherData = dataModel {
            self.cityLabel.text = weatherData.cityName
            self.weatherDescriptionLabel.text = weatherData.temperatureSummary
            self.dateTimeLabel.text = weatherData.date
            self.tempretureLabel.text = weatherData.temperature
            self.tempMaxLabel.text = weatherData.tempMax
            self.tempMinLabel.text = weatherData.tempMin
            if let icon = weatherData.weatherIcon {
                self.weatherIconImageView.image = UIImage(named: icon)
            }
            if let bgImage = weatherData.weatherBackgroundImage {
                self.weatherImageView.image = UIImage(named: bgImage)
            }
            
            self.tempretureUnitIconImageView.image = UIImage(named: SettingsManager.shared.check(measurementUnit: .metric) ? .CelsiusIcon : .Fahrenheit)
            self.tempMaxUnitIconImageView.image = UIImage(named: SettingsManager.shared.check(measurementUnit: .metric) ? .CelsiusIcon : .Fahrenheit)
            self.tempMinUnitIconImageView.image = UIImage(named: SettingsManager.shared.check(measurementUnit: .metric) ? .CelsiusIcon : .Fahrenheit)
        }
    }
}
