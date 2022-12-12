//
//  CocktailClass.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 07/11/2022.
//

import UIKit

enum baseAlc:String{
    case vodka="Wodka"
    case gin="Gin"
    
}
public enum sour:String{
    case cytryna = "Cytryna"
    case limonka = "Limonka"
    case inny = "inny"
}

enum sweet:String{
    case simple = "Syrop cukrowy"
    
}



class technika{
    var SposobWykonania:String
    var Nazwa:String
    init(SposobWykonania: String, Nazwa: String) {
        self.SposobWykonania = SposobWykonania
        self.Nazwa = Nazwa
    }
}

/*class cocktail:Przepis{
    var sour:sour
    let technika:technika
    var sweet:sweet
    init(sour: sour,sweet:sweet, technika:technika, ProfilSmakowy: String, CzasPrzygotowania: Int, SposobPrzygotowania: String, Koszt: Int, listaskladnikow: [skladnik], NazwaPrzepisu: String, Autor: String?, Wstep: String?, Ocena: Int? = nil) {
        self.sour = sour
        self.technika = technika
        self.sweet = sweet
        super.init(ProfilSmakowy: ProfilSmakowy, CzasPrzygotowania: CzasPrzygotowania, SposobPrzygotowania: SposobPrzygotowania, Koszt: Koszt, listaskladnikow: listaskladnikow, NazwaPrzepisu: NazwaPrzepisu, Autor: Autor, Wstep: Wstep)
    }
}
*/
