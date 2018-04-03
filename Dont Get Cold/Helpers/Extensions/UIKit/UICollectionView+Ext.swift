//
//  UICollectionView+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 4/3/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

typealias CollectionViewCellIdentifier = AppConstants.CollectionViewCellIdentifiers

extension UICollectionView {
    func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: CollectionViewCellIdentifier) {
        register(cellClass, forCellWithReuseIdentifier: identifier.rawValue)
    }
    
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: CollectionViewCellIdentifier) {
        register(nib, forCellWithReuseIdentifier: identifier.rawValue)
    }
    
    func dequeueReusableCell(withReuseIdentifier identifier: CollectionViewCellIdentifier, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: identifier.rawValue, for: indexPath)
    }
}

