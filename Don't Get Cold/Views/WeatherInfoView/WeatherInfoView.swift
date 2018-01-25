//
//  WeatherInfoView.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/23/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {

    //MARK: Members
    @IBOutlet weak var weatherInfoImageView: UIImageView!
    @IBOutlet weak var weatherInfoDataLabel: UILabel!
    @IBOutlet weak var weatherInfoTypeLabel: UILabel!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
