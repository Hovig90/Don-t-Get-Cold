//
//  ShortcutItem.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 3/20/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

enum ShortcutType: String {
    case add
    case search
}

struct ShortcutItem {
    var id: Int = 0
    var type: String
    var title: String
    var subTitle: String?
    var icon: UIApplicationShortcutIcon?
    var userInfo: [AnyHashable : Any]?
    
    init(withStortcutType type: ShortcutType) {
        switch type {
        case .add:
            self.type = type.rawValue
            self.title = "Add"
            self.icon = UIApplicationShortcutIcon(type: .add)
        case .search:
            self.type = type.rawValue
            self.title = "Search"
            self.icon = UIApplicationShortcutIcon(type: .search)
        }
    }
    
    init(dynamicItemWithTitle title: String, subTitle: String?, icon: UIApplicationShortcutIcon?, userInfo: [AnyHashable : Any]? = nil) {
        self.type = "custom"
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
        self.userInfo = userInfo
    }
}
