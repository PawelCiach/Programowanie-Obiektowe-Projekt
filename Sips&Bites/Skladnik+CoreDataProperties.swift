//
//  Skladnik+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 28/12/2022.
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

/*private enum CodingKeys:String,CodingKey{
    case nazwaSkladnika,danie
}
extension Skladnik :Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nazwaSkladnika, forKey: .nazwaSkladnika)
        
        
    }
}*/
