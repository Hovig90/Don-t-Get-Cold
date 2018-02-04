//
//  WeatherTableViewCell.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cornerRadiusView: UIView!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        backgroundImageView.cornerRadius(20)
        cornerRadiusView.layerShadow(withColor: UIColor(), opacity: 0.8, offset: CGSize(width: 0, height: 0), radius: 3, path: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
