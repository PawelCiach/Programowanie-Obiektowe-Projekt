//
//  Skladnik+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Paweł Ciach on 20/12/2022.
//
//

import Foundation
import CoreData


extension Skladnik {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Skladnik> {
        return NSFetchRequest<Skladnik>(entityName: "Skladnik")
    }

    @NSManaged public var nazwaSkladnika: String?
    @NSManaged public var cocktail: NSSet?
    @NSManaged public var danie: NSSet?

}

// MARK: Generated accessors for cocktail
extension Skladnik {

    @objc(addCocktailObject:)
    @NSManaged public func addToCocktail(_ value: Cocktail)

    @objc(removeCocktailObject:)
    @NSManaged public func removeFromCocktail(_ value: Cocktail)

    @objc(addCocktail:)
    @NSManaged public func addToCocktail(_ values: NSSet)

    @objc(removeCocktail:)
    @NSManaged public func removeFromCocktail(_ values: NSSet)

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
