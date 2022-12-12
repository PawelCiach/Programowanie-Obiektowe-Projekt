//
//  newCocktailVC.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 05/12/2022.
//

import UIKit
import CoreData

class newCocktailVC: UIViewController,UITextFieldDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   
    @IBOutlet weak var nowaNazwa: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowaNazwa.delegate = self
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addButtonTapped(_ sender: Any) {
        let nazwa: String = nowaNazwa.text!
        if (nazwa.isEmpty == false){
            let nowyCocktail = Cocktail(context: self.context)
            nowyCocktail.nazwaPrzepisu = nowaNazwa.text
            do{
                try self.context.save()
            }
            catch{
                
            }
            
        }
        else{
            print ("puste pole")
        }
        performSegue(withIdentifier: "backToCocktaileVC", sender: self)
    }
    

    
}

