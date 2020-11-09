//
//  AppDelegate.swift
//  WalletChallengeApp
//
//  Created by Robert on 02.11.2020.
//  Copyright © 2020 Robert. All rights reserved.
//

import UIKit
import WRootUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        // Override point for customization after application launch.
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = WRootController()
        root.addRootController()
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
}

