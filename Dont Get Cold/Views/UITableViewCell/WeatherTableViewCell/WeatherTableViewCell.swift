//
//  WeatherTableViewCell.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    //MARK: Members
    var dataModel: CurrentWeather? {
        didSet {
            updateView()
        }
    }
    var isDeletable: Bool = true
    
    //MARK: Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cornerRadiusView: UIView!
    @IBOutlet weak var backgroundImageViewContainerView: UIView!
    @IBOutlet weak var measurementUnitImageView: UIImageView!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        backgroundImageViewContainerView.cornerRadius(15)
        cornerRadiusView.regularShadow()
        cityNameLabel.regularShadow()
        subTitleLabel.regularShadow()
        tempLabel.regularShadow()
        measurementUnitImageView.regularShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func parallaxForCell(onTableView tableView: UITableView, didScrollOnView view: UIView) {
        let rectInSuperView = tableView.convert(self.frame, to: view)
    
        if rectInSuperView.origin.y > UIScreen.height() {
            return
        }
        let distanceFromCenter = view.frame.height / 2 - rectInSuperView.minY
        let difference = self.backgroundImageView.frame.height - self.frame.height
        let move = (distanceFromCenter / view.frame.height) * difference
        
        var imageRect = self.backgroundImageView.frame
        imageRect.origin.y = -(difference / 2) + move
        self.backgroundImageView.frame = imageRect
    }
    
    //MARK: Private
    private func updateView() {
        if let weather = dataModel {
            self.cityNameLabel.text = weather.cityName
            self.subTitleLabel.text = weather.temperatureSummary
            self.tempLabel.text = weather.temperature
            if let bgImage = weather.weatherBackgroundImage {
                self.backgroundImageView.image = UIImage(named: bgImage)
            }
            self.measurementUnitImageView.image = UIImage(named: SettingsManager.shared.check(measurementUnit: .metric) ? .CelsiusIcon : .Fahrenheit)
        }
    }
}
