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
    var usersNames: [String]
}

class FriendViewModel {
    
    let service = VKSDKService()
    var group = [Group]()
    var filterGroup = [Group]()

    func loadModel(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        let request = service.getFriends()
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
    
    func grouping(users: [UserModel]) {
        
        var nameUsers = [String]()
        
        var dictionary = [String: [String]]()
        
        for i in 0..<users.count {
            nameUsers.append(users[i].name)
        }
        for user in nameUsers {
            let userKey = String(user.prefix(1))
            if var userValues = dictionary[userKey] {
                userValues.append(user)
                dictionary[userKey] = userValues
            } else {
                dictionary[userKey] = [user]
            }
        }
        for item in dictionary {
            self.group.append(Group(title: item.key, usersNames: item.value))
        }
        group = group.sorted(by: { $0.title < $1.title })
        filterGroup = group
    }
    
    func countOfSector() -> Int {
        return filterGroup.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return filterGroup[section].usersNames.count
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        return filterGroup[section].title
    }
    
    func fillingTableView(indexPath: IndexPath) -> String? {
        return filterGroup[indexPath.section].usersNames[indexPath.row]
    }
    
    func searchBar(textDidChange searchText: String) {
        filterGroup = group
        if searchText.count != 0 {
            for i in 0..<group.count {
                filterGroup[i].usersNames = group[i].usersNames.filter({ $0.range(of: searchText, options: .caseInsensitive) != nil })
                filterGroup[i].title = ""
            }
        }
    }
}
