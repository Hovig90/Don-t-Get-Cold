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
        
        weatherInfoImageView.layerShadow(withColor: UIColor(hex: 0x000000, alpha: 0.6), opacity: 0.6, offset: CGSize(width: 2, height: 2), radius: 3, path: nil)
        weatherInfoDataType.layerShadow(withColor: UIColor(hex: 0x000000, alpha: 0.6), opacity: 0.6, offset: CGSize(width: 2, height: 2), radius: 3, path: nil)
        weatherInfoDataValue.layerShadow(withColor: UIColor(hex: 0x000000, alpha: 0.6), opacity: 0.6, offset: CGSize(width: 2, height: 2), radius: 3, path: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
