//
//  VKSDKService.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import VK_ios_sdk

class VKSDKService {
    
    var controller: UIViewController
    let SCOPE = ["friends", "email"]
    let sdkInstance = VKSdk.initialize(withAppId: "7215778")

    func authorize() {
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if state == VKAuthorizationState.authorized {
                AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            } else if error != nil {
                let alert = UIAlertController(title: nil, message: error.debugDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.controller.present(alert, animated: true)
            } else {
                AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
            }
        }
    }
    
    func registerDelegate(delegate: VKSdkDelegate, uiDelegate: VKSdkUIDelegate) {
        sdkInstance?.register(delegate)
        sdkInstance?.uiDelegate = uiDelegate
    }

    init(controller: UIViewController) {
        self.controller = controller
    }
}
