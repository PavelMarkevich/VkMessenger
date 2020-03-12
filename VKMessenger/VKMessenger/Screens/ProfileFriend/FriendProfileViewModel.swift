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
    
    func save(_ user: UserModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
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
}
