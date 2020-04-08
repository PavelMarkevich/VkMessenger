//
//  FavoritesFriendsViewModel.swift
//  VKMessenger
//
//  Created by Admin on 11/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoritesFriendsViewModel {
    
    var usersGroups = [Group]()
    var filterUsersGroups = [Group]()
    
    let managedContext = AppDelegate.shared.persistentContainer.viewContext
    
    func fearchRequest() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let user = try managedContext.fetch(fetchRequest)
            grouping(userModel: user)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func grouping(userModel: [User]) {
        usersGroups = [Group]()
        var dictionary = [String: [UserModel]]()
        var users = [UserModel]()
        for user in userModel {
            let name = user.name
            let bdate = user.bdate
            let status =  user.status
            let id = user.id as NSNumber
            let data = user.photo! as Data
            users.append(UserModel(name: name, bdate: bdate, status: status, urlPhoto: nil, id: id, data: data))
        }
        for user in users {
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
        if !searchText.isEmpty {
            for i in 0..<usersGroups.count{
                filterUsersGroups[i].usersModels = usersGroups[i].usersModels.filter({ $0.name.range(of: searchText, options: .caseInsensitive) != nil })
                filterUsersGroups[i].title = ""
            }
        }
    }
}
