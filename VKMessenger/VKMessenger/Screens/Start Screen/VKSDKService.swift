//
//  VKSDKService.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import VK_ios_sdk

enum AuthResult {
    case authorized
    case error(Error)
    case login
}

class VKSDKService {
    
    let SCOPE = ["friends", "email"]
    let sdkInstance = VKSdk.initialize(withAppId: "7215778")
    var delegate: VKDelegate?

    func authorize(controller: UIViewController, completion: @escaping (Result<Bool, Error>) -> Void) {
        VKSdk.wakeUpSession(SCOPE) { (state, error) in
            if state == VKAuthorizationState.authorized {
                completion(.success(true))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(false))
            }
        }
    }
    
    func getUser() -> VKRequest? {
        return VKApi.users()?.get(["fields" : "nickname, screen_name, sex, bdate, city, country, timezone, photo, photo_medium, photo_big, photo_200_orig, has_mobile, contacts, education, online, counters, relation, last_seen, activity, can_write_private_message, can_see_all_posts, can_post, universities"])
    }

    func getFriends() -> VKRequest? {
        return VKApi.friends()?.get(["fields" : "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"])
    }
    
    func login(from controller: UIViewController, completion: @escaping (Bool) -> Void) {
        delegate = VKDelegate(controller: controller, completion: completion)
        sdkInstance?.register(delegate)
        sdkInstance?.uiDelegate = delegate
        VKSdk.authorize(SCOPE)
    }
    
    func logout() {
        VKSdk.forceLogout()
    }
}
