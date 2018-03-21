//
//  UITableView+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 3/20/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UITableView {
    
    //MARK: UIRefreshControl
    func activateRefreshControl(_ target: Any, action: Selector) {
        let refreshControl = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: UIScreen.width(), height: 50))
        refreshControl.tag = AppConstants.tableViewRefreshControl
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        addSubview(refreshControl)
        sendSubview(toBack: refreshControl)
    }
    
    func isRefreshing() -> Bool {
        return refreshControl().isRefreshing
    }
    
    func endRefreshing() {
        refreshControl().endRefreshing()
    }
    
    func dismissRefreshing() {
        refreshControl().endRefreshing()
        refreshControl().isHidden = true
    }
    
    //MARK: Private
    private func refreshControl() -> UIRefreshControl {
        if let refreshControl = viewWithTag(AppConstants.tableViewRefreshControl) as? UIRefreshControl {
            return refreshControl
        }
        
        fatalError("The app crashed because you tried to access the refresh control before initializing it.")
    }
}

extension UITableView {
    //MARK: UIActivityIndicatorView
    func activityIndicator(center: CGPoint = CGPoint.zero, loadingInProgress: Bool) {
        let tag = AppConstants.tableViewActivityIndicatorView
        
        if loadingInProgress {
            let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            indicator.tag = tag
            indicator.activityIndicatorViewStyle = .whiteLarge
            indicator.center = center
            indicator.startAnimating()
            indicator.hidesWhenStopped = true
            self.addSubview(indicator)
        } else {
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
