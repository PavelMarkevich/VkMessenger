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
    var groupUsers = [Group]()
    var filterGroupUsers = [Group]()
    var usersModel = [UserModel]()

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
    
    func getUserModel(usersModel: [UserModel]) {
        self.usersModel = usersModel
        grouping()
    }
    
    func grouping() {
        
        var nameUsers = [String]()
        
        var dictionary = [String: [String]]()
        
        for i in 0..<usersModel.count {
            nameUsers.append(usersModel[i].name)
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
            self.groupUsers.append(Group(title: item.key, usersNames: item.value))
        }
        groupUsers = groupUsers.sorted(by: { $0.title < $1.title })
        filterGroupUsers = groupUsers
    }
    
    func countOfSections() -> Int {
        return filterGroupUsers.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return filterGroupUsers[section].usersNames.count
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        return filterGroupUsers[section].title
    }
    
    func fillingTableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendTableViewCell
        cell.configure(with: filterGroupUsers[indexPath.section].usersNames[indexPath.row])
        return cell
    }
    
    func searchBar(textDidChange searchText: String) {
        filterGroupUsers = groupUsers
        if searchText.count != 0 {
            for i in 0..<groupUsers.count {
                filterGroupUsers[i].usersNames = groupUsers[i].usersNames.filter({ $0.range(of: searchText, options: .caseInsensitive) != nil })
                filterGroupUsers[i].title = ""
            }
        }
    }
}
