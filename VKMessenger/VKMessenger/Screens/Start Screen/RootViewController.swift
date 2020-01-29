//
//  RootViewController.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chekState()
    }
    
    func chekState() {
        let servise = VKSDKService(controller: self)
        if servise.authorize() == true {
            AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        } else {
            AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        }
    }
}
