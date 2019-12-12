//
//  ViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginViewController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {

    let SCOPE = ["friends", "email"];
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let sdkInstance = VKSdk.initialize(withAppId: "7215778")
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if state == VKAuthorizationState.authorized {
//                let request = VKApi.friends()?.get(["fields" : "nickname, status"])
//                request?.execute(resultBlock: { (response) in
//                    response?.parsedModel
//                }, errorBlock: { (error) in
//
//                })
            } else if error != nil {
                let alert = UIAlertController(title: nil, message: error.debugDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func authorize(_ sender: Any) {
        VKSdk.authorize(self.SCOPE)
    }
    
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result?.token != nil {
            
        } else if result.error != nil  {
            let alert = UIAlertController(title: nil, message:"Access denied\n%@ \(String(describing: result.error))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        let alert = UIAlertController(title: nil, message: "Access denied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: self.navigationController?.topViewController)
    }
}

