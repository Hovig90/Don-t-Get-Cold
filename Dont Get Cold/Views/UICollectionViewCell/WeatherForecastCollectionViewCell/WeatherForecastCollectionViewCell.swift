//
//  WeatherForecastCollectionViewCell.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/25/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {

    //MARK: Outlets
    @IBOutlet weak var weatherForecastTopLabel: UILabel!
    @IBOutlet weak var weatherForecastImageView: UIImageView!
    @IBOutlet weak var weatherForecastBottomLabel: UILabel!
    @IBOutlet weak var backgroundAlphaView: UIView!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherForecastTopLabel.regularShadow()
        weatherForecastImageView.regularShadow()
        weatherForecastBottomLabel.regularShadow()
    }
}
