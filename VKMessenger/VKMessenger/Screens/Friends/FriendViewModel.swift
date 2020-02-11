//
//  FriendViewModel.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import VK_ios_sdk

class FriendViewModel {
    
    let request = VKApi.friends()?.get(["fields" : "nickname, photo_200_orig, online"])

    func loadModel(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        request?.execute(resultBlock: { response in
            var array = [VKUsersArray]()
            var arrayUser = [UserModel]()
            array.append((response?.parsedModel as! VKUsersArray))
            for i in 0..<array[0].count {
                arrayUser.append(UserModel(name: array[0][i].first_name + " " + array[0][i].last_name, bdate: "", status: ""))
            }
            completion(.success(arrayUser))
        }, errorBlock: { error in
            completion(.failure(error ?? NSError()))
        })
    }
    
    func createDictionary(users: [String], dictionary: inout [String: [String]], userSection: inout [String] ) {
        dictionary = [String: [String]]()
        userSection = [String]()
        for user in users {
            let userKey = String(user.prefix(1))
            if var userValues = dictionary[userKey] {
                userValues.append(user)
                dictionary[userKey] = userValues
            } else {
                dictionary[userKey] = [user]
            }
        }
        userSection = [String](dictionary.keys)
        userSection = userSection.sorted(by: { $0 < $1 })
    }

}
