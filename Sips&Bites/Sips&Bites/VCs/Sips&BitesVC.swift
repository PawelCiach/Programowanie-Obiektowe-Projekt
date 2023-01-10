//
//  Sips&BitesVC.swift
//  Sips&Bites
//
//  Created by Paweł Ciach on 24/10/2022.
//

import UIKit
import CoreData

class Sips_BitesVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonTapped(_ sender: Any){
        performSegue(withIdentifier: "toMenuVC", sender: nil)
    }
}
