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
    @IBOutlet weak var backgroundImageViewContainerView: UIView!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        backgroundImageViewContainerView.cornerRadius(15)
        cornerRadiusView.layerShadow(withColor: UIColor(hex: 0x000000, alpha: 0.2), opacity: 0.8, offset: CGSize(width: 0, height: 0), radius: 3, path: nil)
        cityNameLabel.layerShadow(withColor: UIColor(hex: 0x000000, alpha: 0.6), opacity: 0.6, offset: CGSize(width: 2, height: 2), radius: 3, path: nil)
        subTitleLabel.layerShadow(withColor: UIColor(hex: 0x000000, alpha: 0.6), opacity: 0.6, offset: CGSize(width: 2, height: 2), radius: 3, path: nil)
        tempLabel.layerShadow(withColor: UIColor(hex: 0x000000, alpha: 0.6), opacity: 0.6, offset: CGSize(width: 2, height: 2), radius: 3, path: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func parallaxForCell(onTableView tableView: UITableView, didScrollOnView view: UIView) {
        let rectInSuperView = tableView.convert(self.frame, to: view)
    
        let distanceFromCenter = view.frame.height / 2 - rectInSuperView.minY
        let difference = self.backgroundImageView.frame.height - self.frame.height
        let move = (distanceFromCenter / view.frame.height) * difference
        
        var imageRect = self.backgroundImageView.frame
        imageRect.origin.y = -(difference / 2) + move
        self.backgroundImageView.frame = imageRect
    }
}
