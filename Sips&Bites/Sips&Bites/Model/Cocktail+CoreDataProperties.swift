//
//  Cocktail+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 05/12/2022.
//
//

import Foundation
import CoreData


extension Cocktail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cocktail> {
        return NSFetchRequest<Cocktail>(entityName: "Cocktail")
    }


}
