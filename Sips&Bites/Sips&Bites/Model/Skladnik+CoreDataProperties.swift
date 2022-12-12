//
//  Skladnik+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 07/12/2022.
//
//

import Foundation
import CoreData


extension Skladnik {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Skladnik> {
        return NSFetchRequest<Skladnik>(entityName: "Skladnik")
    }

    @NSManaged public var nazwaSkladnika: String?
    @NSManaged public var danie: Danie?

}

extension Skladnik : Identifiable {

}
