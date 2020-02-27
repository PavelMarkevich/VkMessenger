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
        let service = VKSDKService()
        service.authorize(controller: self) { result in
            switch result {
            case .success(let state):
                if state == true {
                    AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
                } else {
                    AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                }
            case .failure(let error):
                print(error)
                AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            }
        }
    }
}
