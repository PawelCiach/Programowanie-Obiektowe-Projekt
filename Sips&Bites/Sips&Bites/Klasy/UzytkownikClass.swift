//
//  UzytkownikClass.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 08/11/2022.
//

import UIKit

enum rola{
    case autor
    case kucharz
    case moderator
    case barman
}

class uzytkownik{
    var Nick:String
    var rola: rola
    init(Nick: String, rola: rola) {
        self.Nick = Nick
        self.rola = rola
    }
}
