//
//  VKDelegate.swift
//  VKMessenger
//
//  Created by Admin on 11/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import VK_ios_sdk

class VKDelegate: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    let contoller: UIViewController
    let completion: (Bool) -> Void
    
    init(controller: UIViewController, completion: @escaping (Bool) -> Void) {
        self.contoller = controller
        self.completion = completion
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token == nil {
            completion(false)
        } else {
            completion(true)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        completion(false)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.contoller.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vc = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc?.present(in: contoller)
    }
}
