//
//  ProfileViewModel.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import VK_ios_sdk

class ProfileViewModel {
    
    let request = VKApi.users()?.get(["fields" : "nickname, photo_200_orig, home_town, online, education, status, university, bdate"])
    
    func loadModel(completion: @escaping (Result<UserModel, Error>) -> Void) {
        request?.execute(resultBlock: { response in
            let name = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).first_name + " " + ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).last_name
            let bdate = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).bdate
            let status = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).status
            
            completion(.success(UserModel(name: name, bdate: bdate!, status: status!)))
        }, errorBlock: { error in
            completion(.failure(error ?? NSError()))
        })
    }
    
}
