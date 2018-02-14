//
//  WeatherInfoTableViewCell.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/24/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var weatherInfoImageView: UIImageView!
    @IBOutlet weak var weatherInfoDataType: UILabel!
    @IBOutlet weak var weatherInfoDataValue: UILabel!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherInfoImageView.regularShadow()
        weatherInfoDataType.regularShadow()
        weatherInfoDataValue.regularShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
