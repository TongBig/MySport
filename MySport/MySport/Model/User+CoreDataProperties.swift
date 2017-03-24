//
//  User+CoreDataProperties.swift
//  MySport
//
//  Created by 宇仝 on 17/3/22.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var passWord: String?
    @NSManaged public var phoneNum: String?

}
