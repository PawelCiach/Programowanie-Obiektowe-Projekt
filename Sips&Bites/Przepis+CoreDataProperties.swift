//
//  Przepis+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 28/12/2022.
//
//

import Foundation
import CoreData


extension Przepis {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Przepis> {
        return NSFetchRequest<Przepis>(entityName: "Przepis")
    }

    @NSManaged public var czasPrzygotowania: Int64
    @NSManaged public var koszt: Int64
    @NSManaged public var nazwaPrzepisu: String?
    @NSManaged public var profilSmakowy: String?
    @NSManaged public var sposobPrzygotowania: String?
    @NSManaged public var wstep: String?
    @NSManaged public var autor: Uzytkownik?
    @NSManaged public var ulubione: NSSet?

}

// MARK: Generated accessors for ulubione
extension Przepis {

    @objc(addUlubioneObject:)
    @NSManaged public func addToUlubione(_ value: Uzytkownik)

    @objc(removeUlubioneObject:)
    @NSManaged public func removeFromUlubione(_ value: Uzytkownik)

    @objc(addUlubione:)
    @NSManaged public func addToUlubione(_ values: NSSet)

    @objc(removeUlubione:)
    @NSManaged public func removeFromUlubione(_ values: NSSet)

}

extension Przepis : Identifiable {

}
