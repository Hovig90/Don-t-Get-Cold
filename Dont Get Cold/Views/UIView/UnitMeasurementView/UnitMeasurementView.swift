//
//  UnitMeasurementView.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/11/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

class UnitMeasurementView: UIView {

    //MARK: Members
    weak var delegate: UnitMeasurementContainerDelegate?
    
    //MARK: Outlets
    @IBOutlet weak var fahrenheitImageView: UIImageView!
    @IBOutlet weak var celsiusImageView: UIImageView!
    @IBOutlet weak var switchView: UISwitch!
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.celsiusImageView.image = UIImage(named: .CelsiusIcon)?.withRenderingMode(.alwaysTemplate)
        self.fahrenheitImageView.image = UIImage(named: .Fahrenheit)?.withRenderingMode(.alwaysTemplate)
        
        let isMetric = SettingsManager.shared.check(measurementUnit: .metric)
        switchView.transform = CGAffineTransform(scaleX: 3, y: 1)
        switchView.setOn(isMetric, animated: true)
        updateMeasurementUnit()
    }
    
    //MARK: Actions
    @IBAction func switchViewTapped(_ sender: Any) {
        SettingsManager.shared.updateMeasurementUnit(with: switchView.isOn ? .metric : .imperial)
        updateMeasurementUnit()
    }
    
    //MARK: Private
    private func updateMeasurementUnit() {
        if let delegate = delegate {
            delegate.didChangeMeasurementUnit()
        }
        if switchView.isOn {
            self.celsiusImageView.tintColor = UIColor(white: 1, alpha: 0.6)
            self.fahrenheitImageView.tintColor = UIColor(hex: .AppGray)
        } else {
            self.fahrenheitImageView.tintColor = UIColor(white: 1, alpha: 0.6)
            self.celsiusImageView.tintColor = UIColor(hex: .AppGray)
        }
    }
}

@objc protocol UnitMeasurementContainerDelegate: NSObjectProtocol {
    @objc func didChangeMeasurementUnit()
}

class UnitMeasurementContainerView: UIView {
    
    //MARK: Members
    private var unitMeasurementView: UnitMeasurementView?
    
    //MARK: Outlets
    @IBOutlet weak var delegate: UnitMeasurementContainerDelegate?
    
    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        unitMeasurementView = Bundle.main.loadNibNamed("UnitMeasurementView", owner: self, options: nil)?.first as? UnitMeasurementView
        unitMeasurementView!.delegate = delegate
        unitMeasurementView!.translatesAutoresizingMaskIntoConstraints = false
        addSubview(unitMeasurementView!)
        unitMeasurementView?.anchorToAllSides(inView: self)
    }
    
    
}
