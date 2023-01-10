//
//  errorAlerts.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 10/01/2023.
//

import UIKit
public class alerts:UIViewController{
    public func coreDataError(){
        let alert=UIAlertController(title: "Błąd", message: "Błąd zapisu", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}

