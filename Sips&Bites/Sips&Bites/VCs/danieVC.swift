
import UIKit
import CoreData

class danieVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return danie?.skladniki?.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingrCell") else{
            return UITableViewCell()
        }
        
        return cell
            
    }
    
    
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var skladniki:[Skladnik]=[]

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var nazwaDania: UILabel!
    var danie: Danie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(danie?.iloscSkladnikow as Any)
        print(danie?.skladniki as Any)
        nazwaDania.text=danie?.nazwaPrzepisu
        
    }
    
    func fetchSkladniki()
    {
        
    }
}
