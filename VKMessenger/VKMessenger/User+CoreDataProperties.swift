//
//  User+CoreDataProperties.swift
//  
//
//  Created by Admin on 17/03/2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var bdate: String?
    @NSManaged public var status: String?
    @NSManaged public var photo: NSDate?

}
