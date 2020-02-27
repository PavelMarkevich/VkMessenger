//
//  FriendViewModel.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import VK_ios_sdk


struct Group {
    var title: String
    var usersModels: [UserModel]
}

class FriendViewModel {
    
    let service = VKSDKService()
    var usersGroups = [Group]()
    var filterUsersGroups = [Group]()

    func loadModel(completion: @escaping (Result<Void, Error>) -> Void) {
        let request = service.getFriends()
        request?.execute(resultBlock: { response in
            var array = [VKUsersArray]()
            var arrayUser = [UserModel]()
            array.append((response?.parsedModel as! VKUsersArray))
            for i in 0..<array[0].count {
                arrayUser.append(UserModel(name: array[0][i].first_name + " " + array[0][i].last_name, bdate: "", status: "", urlPhoto: array[0][i].photo_200_orig))
            }
            self.grouping(userModel: arrayUser)
            completion(.success(()))
        }, errorBlock: { error in
            completion(.failure(error ?? NSError()))
        })
    }
    
    func grouping(userModel: [UserModel]) {
        var dictionary = [String: [UserModel]]()
        for user in userModel {
            let userKey = String(user.name.prefix(1))
            if var userValues = dictionary[userKey] {
                userValues.append(user)
                dictionary[userKey] = userValues
            } else {
                dictionary[userKey] = [user]
            }
        }
        for item in dictionary {
            self.usersGroups.append(Group(title: item.key, usersModels: item.value))
        }
        usersGroups = usersGroups.sorted(by: { $0.title < $1.title })
        filterUsersGroups = usersGroups
    }
    
    func countOfSections() -> Int {
        return filterUsersGroups.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return filterUsersGroups[section].usersModels.count
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        return filterUsersGroups[section].title
    }
    
    func getUser(at indexPath: IndexPath) -> UserModel {
        return filterUsersGroups[indexPath.section].usersModels[indexPath.row]
    }
    
    func searchBar(textDidChange searchText: String) {
        filterUsersGroups = usersGroups
        if searchText.count != 0 {
            for i in 0..<usersGroups.count{
                filterUsersGroups[i].usersModels = usersGroups[i].usersModels.filter({ $0.name.range(of: searchText, options: .caseInsensitive) != nil })
                filterUsersGroups[i].title = ""
            }
        }
    }
}

