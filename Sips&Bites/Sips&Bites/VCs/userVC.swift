
import UIKit
import CoreData

class userVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Outlets and actions
    
    @IBOutlet weak var imieField: UITextField!
    @IBOutlet weak var nazwiskoField: UITextField!
    @IBOutlet weak var rolaField: UITextField!
    
    @IBAction func imieEditingEnd(_ sender: Any) {
        currentuser?.imie=imieField.text
        save()
    }
    @IBAction func nazwiskoEditEnd(_ sender: Any) {
        currentuser?.nazwisko=nazwiskoField.text
        save()
    }
    @IBAction func rolaEditEnd(_ sender: Any) {
        currentuser?.rola=rolaField.text
        save()
    }
    
    
    
    //MARK: - Zmienne i tablice
    var us:[Uzytkownik]?
    var currentuser:Uzytkownik?
    
    
    //MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        if(us?.isEmpty==true){
            _=Uzytkownik(context: context)
            save()
        }
        fetchUser()
        currentuser=us![0]
        imieField.text=currentuser?.imie
        nazwiskoField.text=currentuser?.nazwisko
        rolaField.text=currentuser?.rola
    }
    
    
    func fetchUser(){
        do{
            self.us=try context.fetch(Uzytkownik.fetchRequest())
        }catch{
            
        }
    }
    
    func save(){
        do{
            try self.context.save()
        }catch{
            let alert=UIAlertController(title: "Błąd", message: "Błąd zapisu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        }
    }
    
    
}
