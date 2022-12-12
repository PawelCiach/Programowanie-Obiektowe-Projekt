//
//  DanieClass.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 07/11/2022.
//

import UIKit

public enum cuisine:String{
    case wloska = "Wloska"
    case azjatycka = "Azjatycka"
    case polska = "Polska"
    case francuska = "Francuska"
}

enum dieta{
    case miesna, weganska, wegetarianska
}

/*class Danie:Przepis{
    let cuisine:cuisine
    let dieta: dieta
    init(cuisine:cuisine,dieta:dieta,ProfilSmakowy: String, CzasPrzygotowania: Int, SposobPrzygotowania: String, Koszt: Int, listaskladnikow: [skladnik], NazwaPrzepisu: String, Autor: String?, Wstep: String?, Ocena: Int? = nil){
        self.cuisine=cuisine
        self.dieta=dieta
        super.init(ProfilSmakowy: ProfilSmakowy, CzasPrzygotowania: CzasPrzygotowania, SposobPrzygotowania: SposobPrzygotowania, Koszt: Koszt, listaskladnikow: listaskladnikow, NazwaPrzepisu: NazwaPrzepisu, Autor: Autor, Wstep: Wstep)
    }
}
*/




