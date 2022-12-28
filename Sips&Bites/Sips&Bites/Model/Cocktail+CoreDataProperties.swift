//
//  Cocktail+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Paweł Ciach on 20/12/2022.
//
//

import Foundation
import CoreData


extension Cocktail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cocktail> {
        return NSFetchRequest<Cocktail>(entityName: "Cocktail")
    }

    @NSManaged public var iloscSkladnikow: [String]?
    @NSManaged public var skladniki: NSOrderedSet?

}

// MARK: Generated accessors for skladniki
extension Cocktail {

    @objc(insertObject:inSkladnikiAtIndex:)
    @NSManaged public func insertIntoSkladniki(_ value: Skladnik, at idx: Int)

    @objc(removeObjectFromSkladnikiAtIndex:)
    @NSManaged public func removeFromSkladniki(at idx: Int)

    @objc(insertSkladniki:atIndexes:)
    @NSManaged public func insertIntoSkladniki(_ values: [Skladnik], at indexes: NSIndexSet)

    @objc(removeSkladnikiAtIndexes:)
    @NSManaged public func removeFromSkladniki(at indexes: NSIndexSet)

    @objc(replaceObjectInSkladnikiAtIndex:withObject:)
    @NSManaged public func replaceSkladniki(at idx: Int, with value: Skladnik)

    @objc(replaceSkladnikiAtIndexes:withSkladniki:)
    @NSManaged public func replaceSkladniki(at indexes: NSIndexSet, with values: [Skladnik])

    @objc(addSkladnikiObject:)
    @NSManaged public func addToSkladniki(_ value: Skladnik)

    @objc(removeSkladnikiObject:)
    @NSManaged public func removeFromSkladniki(_ value: Skladnik)

    @objc(addSkladniki:)
    @NSManaged public func addToSkladniki(_ values: NSOrderedSet)

    @objc(removeSkladniki:)
    @NSManaged public func removeFromSkladniki(_ values: NSOrderedSet)

}
