//
//  WeatherTableViewCell.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 2/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

protocol WeatherTableViewCellDelegate: NSObjectProtocol {
    func deleteCell(_ cell: WeatherTableViewCell, completion: (() -> Void))
}

class WeatherTableViewCell: UITableViewCell {

    //MARK: Members
    weak var delegate: WeatherTableViewCellDelegate?
    
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
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(moveCell(_:)))
        self.cornerRadiusView.addGestureRecognizer(pan)
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
    
    //MARK: Private
    @objc func moveCell(_ sender: UIPanGestureRecognizer) {
        let originalLocation = self.center
        
        switch sender.state {
        case .began, .changed://self.bounds.origin.x -
            if sender.translation(in: self).x < 0 {
                let newCenter = CGPoint(x: originalLocation.x + sender.translation(in: self).x, y: self.cornerRadiusView.center.y)
                self.cornerRadiusView.center = newCenter
                self.cornerRadiusView.alpha = (self.cornerRadiusView.frame.origin.x + self.cornerRadiusView.bounds.width) / (UIScreen.width())
            }
            
        case .cancelled: print("Cancelled")
        case .ended:
            if self.cornerRadiusView.frame.origin.x - (16 * 2) < (-UIScreen.width() / 3) * 2 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cornerRadiusView.center = CGPoint(x: -UIScreen.width(), y: self.cornerRadiusView.center.y)
                    self.cornerRadiusView.alpha = 0
                }, completion: { (finished) in
                    if finished {
                        if let delegate = self.delegate {
                            delegate.deleteCell(self, completion: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                    self.cornerRadiusView.center = CGPoint(x: originalLocation.x, y: self.cornerRadiusView.center.y)
                                    self.cornerRadiusView.alpha = 1
                                })
                            })
                        }
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.cornerRadiusView.center = CGPoint(x: originalLocation.x, y: self.cornerRadiusView.center.y)
                    self.cornerRadiusView.alpha = 1
                })
            }
        case .failed: print("Failed")
        case .possible: print("Possible")
        default: break
        }
        
    }
}
