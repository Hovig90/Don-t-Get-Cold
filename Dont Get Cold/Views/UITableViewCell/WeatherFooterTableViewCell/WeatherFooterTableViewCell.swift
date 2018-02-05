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
}

class WeatherFooterTableViewCell: UITableViewHeaderFooterView {

    //MARK: Members
    weak var delegate: WeatherFooterTableViewCellDelegate?
    
    //MARK: Outlets

    
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
