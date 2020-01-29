//
//  VKSDKService.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import VK_ios_sdk

class VKSDKService: NSObject, VKSdkDelegate,VKSdkUIDelegate {
    
    var controller: UIViewController
    let SCOPE = ["friends", "email"]
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let token = result.token {
            // success flow
            AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
            print(token)
        } else {
            // error
            let message = result.error?.localizedDescription ?? "someting went wrong"
            let alert = UIAlertController(title: nil, message:"Access denied\n \(message)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.controller.present(alert, animated: true)
        }

    }
    
    func vkSdkUserAuthorizationFailed() {
        let alert = UIAlertController(title: nil, message: "Access denied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.controller.present(alert, animated: true)
        self.controller.navigationController?.popViewController(animated: true)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        controller.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: self.controller.navigationController?.topViewController)
    }
    
    func authorize() -> Bool {
        var stateAuthorize: Bool = false
        let sdkInstance = VKSdk.initialize(withAppId: "7215778")
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if state == VKAuthorizationState.authorized {
                stateAuthorize = true
            } else if error != nil {
                let alert = UIAlertController(title: nil, message: error.debugDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.controller.present(alert, animated: true)
            }
        }
        return stateAuthorize
    }
    
    func stt(delegate: VKSdkDelegate, uiDelegate: VKSdkUIDelegate) {
        let sdkInstance = VKSdk.initialize(withAppId: "7215778")
        sdkInstance?.register(delegate)
        sdkInstance?.uiDelegate = uiDelegate
    }

    init(controller: UIViewController) {
        self.controller = controller
    }
}
