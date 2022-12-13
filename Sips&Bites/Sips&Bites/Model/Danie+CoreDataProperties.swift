//
//  Danie+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 13/12/2022.
//
//

import Foundation
import CoreData


extension Danie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Danie> {
        return NSFetchRequest<Danie>(entityName: "Danie")
    }

    @NSManaged public var iloscSkladnikow: [String]?
    @NSManaged public var skladniki: NSSet?

}

// MARK: Generated accessors for skladniki
extension Danie {

    @objc(addSkladnikiObject:)
    @NSManaged public func addToSkladniki(_ value: Skladnik)

    @objc(removeSkladnikiObject:)
    @NSManaged public func removeFromSkladniki(_ value: Skladnik)

    @objc(addSkladniki:)
    @NSManaged public func addToSkladniki(_ values: NSSet)

    @objc(removeSkladniki:)
    @NSManaged public func removeFromSkladniki(_ values: NSSet)

}
