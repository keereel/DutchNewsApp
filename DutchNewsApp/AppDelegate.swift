//
//  AppDelegate.swift
//  DutchNewsApp
//
//  Created by Kirill Sedykh on 02.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let headlinesAssembly = HeadlinesAssembly()
        let mainView = headlinesAssembly.assemble()
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [mainView]
        navigationController.navigationBar.barTintColor = UIColor.baseBackgroundColor
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
}

