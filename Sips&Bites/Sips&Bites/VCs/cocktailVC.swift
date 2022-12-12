
import UIKit
import CoreData

class cocktailVC: UIViewController {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var nazwa: UILabel!
    var activeCk: Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nazwa.text=activeCk?.nazwaPrzepisu ?? "Wystąpił błąd"
    }
    
    @IBAction func trashTapped(_ sender: Any) {
        self.context.delete(activeCk!)
        do{
            try self.context.save()
        }
        catch{
            
        }
        performSegue(withIdentifier: "backToCocktaileVC", sender: self)
    }
}
