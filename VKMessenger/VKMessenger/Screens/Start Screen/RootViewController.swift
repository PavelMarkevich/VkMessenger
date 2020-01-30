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
        let servise = VKSDKService(controller: self)
        servise.authorize()
    }
}
