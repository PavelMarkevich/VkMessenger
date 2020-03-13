//
//  FriendProfileViewModel.swift
//  VKMessenger
//
//  Created by Admin on 11/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FriendProfileViewModel {
    
    let managedContext = AppDelegate.shared.persistentContainer.viewContext
    var user: UserModel!
    
    func save(_ user: UserModel) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(user.name, forKeyPath: "name")
        person.setValue(user.id, forKey: "id")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete(_ user: UserModel) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        deleteFetch.predicate = NSPredicate(format: "id = %@", user.id)
        do {
            let test = try managedContext.fetch(deleteFetch)
            if !test.isEmpty {
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
            }
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func chekStateButtton(_ user: UserModel) -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetch.predicate = NSPredicate(format: "id = %@", user.id)
        do {
            let test = try managedContext.fetch(fetch)
            if test.isEmpty {
                return true
            } else {
                return false
            }
        } catch {
            print(error)
        }
        return true
    }
    
    func getUser(user: UserModel) {
        self.user = user
    }
    
    func stateChange(sender: UIButton, user: UserModel) {
        let state = chekStateButtton(user)
        if state {
            sender.isSelected = !sender.isSelected
            sender.addTarget(self, action: #selector(saved(_:)), for: .touchUpInside)
        } else {
            sender.isSelected = !sender.isSelected
            sender.addTarget(self, action: #selector(deleted(_:)), for: .touchUpInside)
        }
//        let state = viewModel.chekStateButtton(user)
//        if state {
//            viewModel.save(user)
//            sender.isSelected = !sender.isSelected
//        } else {
//            viewModel.delete(user)
//            sender.isSelected = !sender.isSelected
//        }
    }
    
    @objc func saved(_ sender: UIButton) {
        save(user)
    }
    
    @objc func deleted(_ sender: UIButton) {
        delete(user)
    }
}
