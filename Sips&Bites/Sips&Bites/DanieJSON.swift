//
//  DanieJSON.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 29/01/2023.
//

import UIKit
import CoreData

public struct DanieJS : Codable{
    let nazwaDania:String?
    let koszt:Int64?
    let czas:Int64?
    let profilSmakowy:String?
    let skladniki:[String]?
    let ilosciSkladnikow:[String]?
    let sposobPrzygotowania:String?
    let autor:String?
    
}
