
import UIKit
import CoreData

class danieVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var nazwaD: UILabel!
    
    @IBAction func trashTapped(_ sender: Any) {
        self.context.delete(danie!)
        do{
            try self.context.save()
        }
        catch{
            print("błąd zapisu")
        }
        performSegue(withIdentifier: "backToDaniaVC", sender: self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return danie?.skladniki?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "abx") else{
            return UITableViewCell()
        }
        
        //cell.textLabel?.text=danie?.skladniki![indexPath.row].nazwaSkladnika
        //cell.textLabel?.text=danie?.iloscSkladnikow![indexPath.row]
        //cell.textLabel?.text=skladniki[indexPath.row].nazwaSkladnika
        //cell.textLabel?.text=skladniki[indexPath.row].nazwaSkladnika
        cell.textLabel?.text=skladniki[indexPath.row].nazwaSkladnika! + " - "+(danie?.iloscSkladnikow![indexPath.row])!
        return cell
            
    }
    
    

    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    


   
    
    var danie: Danie?
    var skladniki:[Skladnik]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        //print(danie?.iloscSkladnikow as Any)
        //print(danie?.skladniki as Any)
        skladniki=danie?.skladniki?.array as! [Skladnik]
        nazwaD.text=danie?.nazwaPrzepisu ?? "Błąd"
        //print(skladniki)
        
        
        
    }
   
    
    
    func fetchSkladniki()
    {
        
    }
}

/*extension Optional where Wrapped == NSOrderedSet {
    func array<T: Hashable>(of: T.Type) -> [T] {
        if let set = self as? Set<T> {
            return Array(set)
        }
        return [T]()
    }
}*/



