//
//  AppDelegate.swift
//  Don't Get Cold
//
//  Created by Hovig Kousherian on 1/21/18.
//  Copyright © 2018 Hovig Kousherian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        application.shortcutItems = ShortcutManager.shared.shortcutItems()
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        openViewController(forShortcutItem: shortcutItem)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if AppConstants.extensionURLScheme == url.absoluteString {
            if let topViewController = getTopViewController() as? MainViewController {
                topViewController.pushViewController(forSelectedCityIndexPathRow: 0, animated: false)
            }
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: Private
    private func openViewController(forShortcutItem item: UIApplicationShortcutItem) {
        if let topViewController = getTopViewController() as? MainViewController {
            if item.type == ShortcutType.add.rawValue || item.type == ShortcutType.search.rawValue {
                topViewController.openAddCityModalViewController()
            } else if item.type == "custom", let userInfo = item.userInfo, let row = userInfo["row"] as? Int {
                topViewController.pushViewController(forSelectedCityIndexPathRow: row, animated: false)
            }
        }
    }
    
    private func getTopViewController() -> UIViewController? {
        if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
            navigationController.popToRootViewController(animated: false)
            return navigationController.topViewController
        }
        
        return nil
    }
}

