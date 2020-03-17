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
    
    func save() {
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
    
    func delete() {
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
    
    func chekStateButtton() -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetch.predicate = NSPredicate(format: "id = %@", user.id)
        do {
            let test = try managedContext.fetch(fetch)
            if test.isEmpty {
                return false
            } else {
                return true
            }
        } catch {
            print(error)
        }
        return true
    }
}
