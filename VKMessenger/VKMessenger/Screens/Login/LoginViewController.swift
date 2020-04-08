//
//  ViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginViewController: UIViewController {

    let servise = VKSDKService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func authorize(_ sender: Any) {
        servise.login(from: self) { loggedIn in
            if loggedIn {
                AppDelegate.shared.window?.rootViewController = R.storyboard.main.tabBarController()
            }
        }
    }
}
