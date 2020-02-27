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
    
    let service = VKSDKService()
    
    func loadModel(completion: @escaping (Result<UserModel, Error>) -> Void) {
        let request = service.getUser()
        request?.execute(resultBlock: { response in
            let name = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).first_name + " " + ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).last_name
            let bdate = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).bdate
            let status = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).status
            let urlPhoto = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).photo_200_orig
            completion(.success(UserModel(name: name, bdate: bdate!, status: status!, urlPhoto: urlPhoto)))
        }, errorBlock: { error in
            completion(.failure(error ?? NSError()))
        })
    }
}
