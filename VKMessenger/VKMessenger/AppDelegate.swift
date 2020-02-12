//
//  AppDelegate.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootViewController")
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return VKSdk.processOpen(url, fromApplication: (options[.sourceApplication] as! String))
    }
    
}

