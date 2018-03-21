//
//  UIApplicationShortcutItem+Ext.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 3/20/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

extension UIApplicationShortcutItem {
    
    convenience init(withShortcutItem item: ShortcutItem) {
        self.init(type: item.type, localizedTitle: item.title, localizedSubtitle: item.subTitle, icon: item.icon, userInfo: item.userInfo)
    }
}
