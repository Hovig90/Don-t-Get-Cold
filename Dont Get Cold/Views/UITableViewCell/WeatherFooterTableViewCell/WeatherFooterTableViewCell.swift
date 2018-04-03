//
//  WeatherFooterTableViewCell.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

protocol WeatherFooterTableViewCellDelegate: NSObjectProtocol {
    func openAddCityModelViewController()
    func reloadViewControllerWithUpdatedMeasurementUnit()
}

extension WeatherFooterTableViewCell: UnitMeasurementContainerDelegate {
    func didChangeMeasurementUnit() {
        if let delegate = delegate {
            delegate.reloadViewControllerWithUpdatedMeasurementUnit()
        }
    }
}

class WeatherFooterTableViewCell: UITableViewHeaderFooterView {

    //MARK: Members
    weak var delegate: WeatherFooterTableViewCellDelegate?
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.openAddCityModelViewController()
        }
    }
}
