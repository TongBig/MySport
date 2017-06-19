//
//  Run+CoreDataProperties.swift
//  MySport
//
//  Created by 宇仝 on 17/3/28.
//  Copyright © 2017年 宇仝. All rights reserved.
//

import Foundation
import CoreData


extension Run {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Run> {
        return NSFetchRequest<Run>(entityName: "Run");
    }

    @NSManaged public var distance: Double
    @NSManaged public var duration: Double
    @NSManaged public var flag: Int64
    @NSManaged public var runid: Int64
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var locations: NSSet?

}

// MARK: Generated accessors for locations
extension Run {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: Location)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: Location)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}
