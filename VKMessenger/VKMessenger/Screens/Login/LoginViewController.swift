//
//  ViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginViewController: UIViewController, VKSdkUIDelegate, VKSdkDelegate {

    let servise = VKSDKService()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        servise.registerDelegate(delegate: self, uiDelegate: self)
        
    }
    
    @IBAction func authorize(_ sender: Any) {
        servise.login()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: self.navigationController?.topViewController)
    }
    
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
            self.present(alert, animated: true)
        }
        
    }
    
    func vkSdkUserAuthorizationFailed() {
        let alert = UIAlertController(title: nil, message: "Access denied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}
