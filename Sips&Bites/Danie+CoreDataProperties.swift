//
//  Danie+CoreDataProperties.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 28/12/2022.
//
//

import Foundation
import CoreData


extension Danie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Danie> {
        return NSFetchRequest<Danie>(entityName: "Danie")
    }

    @NSManaged public var iloscSkladnikow: [String]?
    @NSManaged public var skladniki: NSOrderedSet?

}

// MARK: Generated accessors for skladniki
extension Danie {

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

/*private enum CodingKeys:String, CodingKey{
    case skladniki, iloscSkladnikow,czasPrzygotowania,koszt,nazwaPrzepisu,profilSmakowy,sposobPrzygotowania,wstep,ocena,autor
}

extension Danie : Encodable{
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nazwaPrzepisu, forKey: .nazwaPrzepisu)
        try container.encode(skladniki, forKey: .skladniki)
        try container.encode(iloscSkladnikow, forKey: .iloscSkladnikow)
        try container.encode(czasPrzygotowania, forKey: .czasPrzygotowania)
        try container.encode(koszt, forKey: .koszt)
        try container.encode(profilSmakowy, forKey: .profilSmakowy)
        try container.encode(sposobPrzygotowania, forKey: .sposobPrzygotowania)
        try container.encode(wstep, forKey: .wstep)
        try container.encode(ocena, forKey: .ocena)
        try container.encode(autor, forKey: .autor)
    }
}*/

/*extension NSManagedObject {
    func toJson() -> String?{
        let keys = Array(self.entity.attributesByName.keys)
        let dict = self.dictionaryWithValues(forKeys: keys)
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict,options: .prettyPrinted)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            return reqJSONStr
        }
        catch{}
        return nil
    }
}*/

extension Danie{
    func toStruct() -> DanieJS{
        let skladnikiArray=self.skladniki?.array as! [Skladnik]
        var skladnikiString:[String]=[]
        for skladnik in skladnikiArray{
            skladnikiString.append(skladnik.nazwaSkladnika ?? "")
        }
        let autor = (self.autor?.imie ?? "") + " " + (self.autor?.nazwisko ?? "")
        let st=DanieJS(nazwaDania: self.nazwaPrzepisu,
                       koszt: self.koszt,
                       czas: self.czasPrzygotowania,
                       profilSmakowy: self.profilSmakowy,
                       skladniki: skladnikiString,
                       ilosciSkladnikow: self.iloscSkladnikow,
                       sposobPrzygotowania: self.sposobPrzygotowania,
                       autor: autor)
        return st
    }
    
}


    
    
    

