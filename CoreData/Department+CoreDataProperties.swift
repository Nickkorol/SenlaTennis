//
//  Department+CoreDataProperties.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 26.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var name: String?
    @NSManaged public var people: NSOrderedSet?

}

// MARK: Generated accessors for people
extension Department {

    @objc(insertObject:inPeopleAtIndex:)
    @NSManaged public func insertIntoPeople(_ value: Employee, at idx: Int)

    @objc(removeObjectFromPeopleAtIndex:)
    @NSManaged public func removeFromPeople(at idx: Int)

    @objc(insertPeople:atIndexes:)
    @NSManaged public func insertIntoPeople(_ values: [Employee], at indexes: NSIndexSet)

    @objc(removePeopleAtIndexes:)
    @NSManaged public func removeFromPeople(at indexes: NSIndexSet)

    @objc(replaceObjectInPeopleAtIndex:withObject:)
    @NSManaged public func replacePeople(at idx: Int, with value: Employee)

    @objc(replacePeopleAtIndexes:withPeople:)
    @NSManaged public func replacePeople(at indexes: NSIndexSet, with values: [Employee])

    @objc(addPeopleObject:)
    @NSManaged public func addToPeople(_ value: Employee)

    @objc(removePeopleObject:)
    @NSManaged public func removeFromPeople(_ value: Employee)

    @objc(addPeople:)
    @NSManaged public func addToPeople(_ values: NSOrderedSet)

    @objc(removePeople:)
    @NSManaged public func removeFromPeople(_ values: NSOrderedSet)

}
