//
//  Skladnik+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 13/12/2022.
//
//

import Foundation
import CoreData


extension Skladnik {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Skladnik> {
        return NSFetchRequest<Skladnik>(entityName: "Skladnik")
    }

    @NSManaged public var nazwaSkladnika: String?
    @NSManaged public var danie: NSSet?

}

// MARK: Generated accessors for danie
extension Skladnik {

    @objc(addDanieObject:)
    @NSManaged public func addToDanie(_ value: Danie)

    @objc(removeDanieObject:)
    @NSManaged public func removeFromDanie(_ value: Danie)

    @objc(addDanie:)
    @NSManaged public func addToDanie(_ values: NSSet)

    @objc(removeDanie:)
    @NSManaged public func removeFromDanie(_ values: NSSet)

}

extension Skladnik : Identifiable {

}
