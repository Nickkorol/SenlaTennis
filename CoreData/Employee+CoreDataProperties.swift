//
//  Employee+CoreDataProperties.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 26.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var department: Department?
    @NSManaged public var games: NSOrderedSet?

}

// MARK: Generated accessors for games
extension Employee {

    @objc(insertObject:inGamesAtIndex:)
    @NSManaged public func insertIntoGames(_ value: Game, at idx: Int)

    @objc(removeObjectFromGamesAtIndex:)
    @NSManaged public func removeFromGames(at idx: Int)

    @objc(insertGames:atIndexes:)
    @NSManaged public func insertIntoGames(_ values: [Game], at indexes: NSIndexSet)

    @objc(removeGamesAtIndexes:)
    @NSManaged public func removeFromGames(at indexes: NSIndexSet)

    @objc(replaceObjectInGamesAtIndex:withObject:)
    @NSManaged public func replaceGames(at idx: Int, with value: Game)

    @objc(replaceGamesAtIndexes:withGames:)
    @NSManaged public func replaceGames(at indexes: NSIndexSet, with values: [Game])

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: Game)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: Game)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSOrderedSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSOrderedSet)

}
