//
//  newDanieVC.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 07/12/2022.
//

import UIKit
import CoreData

class newDanieVC: UIViewController, UITextFieldDelegate {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let skladnikiAkt:[Skladnik]=[]
    
    let wszystkieSkl:[Skladnik]=[]
    

    @IBOutlet weak var nazwaDania: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nazwaDania.delegate=self
        // Do any additional setup after loading the view.
    }
    
    
    

   

}
