//
//  menuVC.swift
//  Sips&Bites
//
//  Created by Paweł Ciach on 24/10/2022.
//

import UIKit

class menuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func daniaTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toDaniaVC", sender: nil)
    }
    
    @IBAction func cocktaileTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toCocktaileVC", sender: nil)
    }
    
    
    @IBAction func userTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toUserVC", sender: nil)
    }
}
