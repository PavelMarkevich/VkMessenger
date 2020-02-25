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
    var usersModel: [UserModel]
}

class FriendViewModel {
    
    let service = VKSDKService()
    var groupUsers = [Group]()
    var filterGroupUsers = [Group]()

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
        grouping(userModel: usersModel)
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
            self.groupUsers.append(Group(title: item.key, usersModel: item.value))
        }
        groupUsers = groupUsers.sorted(by: { $0.title < $1.title })
        filterGroupUsers = groupUsers
    }
    
    func countOfSections() -> Int {
        return filterGroupUsers.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return filterGroupUsers[section].usersModel.count
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        return filterGroupUsers[section].title
    }
    
    func fillingTableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendTableViewCell
        cell.configure(with: filterGroupUsers[indexPath.section].usersModel[indexPath.row].name)
        return cell
    }
    
    func searchBar(textDidChange searchText: String) {
        filterGroupUsers = groupUsers
        if searchText.count != 0{
            for i in 0..<groupUsers.count{
                filterGroupUsers[i].usersModel = groupUsers[i].usersModel.filter({ $0.name.range(of: searchText, options: .caseInsensitive) != nil })
                filterGroupUsers[i].title = ""
            }
        }
    }
}

