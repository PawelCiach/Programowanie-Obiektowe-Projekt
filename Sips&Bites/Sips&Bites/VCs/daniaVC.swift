
import UIKit
import CoreData



class daniaVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dania: [Danie]=[]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDanieVC"){
            if let destvc = segue.destination as? danieVC{
                destvc.danie = sender as? Danie
            }
        }
    }
    
    @IBAction func unwind(_ seg:UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDanie()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchDanie()
    }
    @IBAction func daniaCategoriesButton(_ sender: Any) {
        performSegue(withIdentifier: "toDaniaCategories", sender: nil)
    }
    
    @IBAction func newDanieButton(_ sender: Any) {
        performSegue(withIdentifier: "toNoweDanie", sender: nil)
    }
    
    func fetchDanie(){
        do{
            self.dania = try context.fetch(Danie.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
}

extension daniaVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dania.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "danieCell")else{
          return UITableViewCell()
        }
        cell.textLabel?.text = dania[indexPath.row].nazwaPrzepisu
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDanieVC", sender: dania[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
