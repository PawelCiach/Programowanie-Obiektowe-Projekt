
import UIKit
import CoreData

class danieVC: UIViewController {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var activeDanie: Danie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
}
