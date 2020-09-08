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
        
        //let headlinesAssembly = HeadlinesAssembly()
        //let rootViewController = headlinesAssembly.assemble()
        let headlinesAssembly = HeadlinesAssembly()
        let mainView = headlinesAssembly.assemble()
        let nav = UINavigationController()
        nav.viewControllers = [mainView]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        //window!.rootViewController = rootViewController
        window!.rootViewController = nav
        window!.makeKeyAndVisible()
        
        return true
    }
}

