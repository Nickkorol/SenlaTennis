//
//  Game+CoreDataProperties.swift
//  SenlaTennis
//
//  Created by Nikita Korolev on 26.02.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var date: Date?
    @NSManaged public var firstScore: Int32
    @NSManaged public var secondScore: Int32
    @NSManaged public var players: NSOrderedSet?

}

// MARK: Generated accessors for players
extension Game {

    @objc(insertObject:inPlayersAtIndex:)
    @NSManaged public func insertIntoPlayers(_ value: Employee, at idx: Int)

    @objc(removeObjectFromPlayersAtIndex:)
    @NSManaged public func removeFromPlayers(at idx: Int)

    @objc(insertPlayers:atIndexes:)
    @NSManaged public func insertIntoPlayers(_ values: [Employee], at indexes: NSIndexSet)

    @objc(removePlayersAtIndexes:)
    @NSManaged public func removeFromPlayers(at indexes: NSIndexSet)

    @objc(replaceObjectInPlayersAtIndex:withObject:)
    @NSManaged public func replacePlayers(at idx: Int, with value: Employee)

    @objc(replacePlayersAtIndexes:withPlayers:)
    @NSManaged public func replacePlayers(at indexes: NSIndexSet, with values: [Employee])

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Employee)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Employee)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSOrderedSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSOrderedSet)

}
