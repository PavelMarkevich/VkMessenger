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
    
    var user: [NSManagedObject] = []
    
    func fearchRequest() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
          user = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getNumberOfSection() -> Int {
        return user.count
    }
    
    func getUserName(for indexPath: IndexPath) -> String {
        let user = self.user[indexPath.row]
        let name = user.value(forKey: "name") as! String
        return name
    }
}
