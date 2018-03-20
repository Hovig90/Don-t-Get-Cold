//
//  UITableView+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 3/20/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UITableView {
    
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
