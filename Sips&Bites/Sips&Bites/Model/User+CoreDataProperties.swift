//
//  User+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 28/12/2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var imie: String?
    @NSManaged public var nazwisko: String?
    @NSManaged public var rola: String?
    @NSManaged public var autor: NSSet?
    @NSManaged public var ulubione: NSSet?

}

// MARK: Generated accessors for autor
extension User {

    @objc(addAutorObject:)
    @NSManaged public func addToAutor(_ value: Przepis)

    @objc(removeAutorObject:)
    @NSManaged public func removeFromAutor(_ value: Przepis)

    @objc(addAutor:)
    @NSManaged public func addToAutor(_ values: NSSet)

    @objc(removeAutor:)
    @NSManaged public func removeFromAutor(_ values: NSSet)

}

// MARK: Generated accessors for ulubione
extension User {

    @objc(addUlubioneObject:)
    @NSManaged public func addToUlubione(_ value: Przepis)

    @objc(removeUlubioneObject:)
    @NSManaged public func removeFromUlubione(_ value: Przepis)

    @objc(addUlubione:)
    @NSManaged public func addToUlubione(_ values: NSSet)

    @objc(removeUlubione:)
    @NSManaged public func removeFromUlubione(_ values: NSSet)

}

extension User : Identifiable {

}
