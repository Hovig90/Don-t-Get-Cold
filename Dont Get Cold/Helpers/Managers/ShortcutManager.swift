//
//  ShortcutManager.swift
//  Dont Get Cold
//
//  Created by Hovig Kousherian on 3/20/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

struct ShortcutManager {
    
    //MARK: Singleton
    static let shared = ShortcutManager()
    
    private init() { }
    
    //MARK: Public
    func shortcutItems() -> [UIApplicationShortcutItem] {
        let searchItem = UIApplicationShortcutItem(withShortcutItem: ShortcutItem(withStortcutType: .search))
        
        if LocationManager.locationStatusAllowed() {
            if let cachedCities = CacheManager.cache.get(forKey: .cities) as? [City], cachedCities.count > 1 {
                if cachedCities.count == 2 {
                    return [
                        UIApplicationShortcutItem(withShortcutItem: ShortcutItem(dynamicItemWithTitle: cachedCities[1].name, subTitle: nil, icon: UIApplicationShortcutIcon(), userInfo: ["row" : 1])),
                        searchItem
                    ]
                } else {
                    return [
                        UIApplicationShortcutItem(withShortcutItem: ShortcutItem(dynamicItemWithTitle: cachedCities[1].name, subTitle: nil, icon: UIApplicationShortcutIcon(), userInfo: ["row" : 1])),
                        UIApplicationShortcutItem(withShortcutItem: ShortcutItem(dynamicItemWithTitle: cachedCities[2].name, subTitle: nil, icon: UIApplicationShortcutIcon(), userInfo: ["row" : 2])),
                        searchItem
                    ]
                }
            }
        } else {
            if let cachedCities = CacheManager.cache.get(forKey: .cities) as? [City], cachedCities.count >= 1 {
                if cachedCities.count == 1 {
                    return [
                        UIApplicationShortcutItem(withShortcutItem: ShortcutItem(dynamicItemWithTitle: cachedCities[0].name, subTitle: nil, icon: UIApplicationShortcutIcon(), userInfo: ["row" : 0])),
                        searchItem
                    ]
                } else {
                    return [
                        UIApplicationShortcutItem(withShortcutItem: ShortcutItem(dynamicItemWithTitle: cachedCities[0].name, subTitle: nil, icon: UIApplicationShortcutIcon(), userInfo: ["row" : 0])),
                        UIApplicationShortcutItem(withShortcutItem: ShortcutItem(dynamicItemWithTitle: cachedCities[1].name, subTitle: nil, icon: UIApplicationShortcutIcon(), userInfo: ["row" : 1])),
                        searchItem
                    ]
                }
            }
        }
        
        
        return [
            searchItem
        ]
    }
    
    func didUpdateShortcuts() {
        UIApplication.shared.shortcutItems = shortcutItems()
    }
}
