//
//  Location+CoreDataProperties.swift
//  MySport
//
//  Created by 宇仝 on 17/3/28.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var run: Run?

}
