
import UIKit
import CoreData



class daniaVC: UIViewController, UITableViewDelegate, UITableViewDataSource,Filtr{
    
    
   
    @IBAction func clearTapped(_ sender: Any) {
        ifSorted=false
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func filtrSkladnik(_ skladniki: [Skladnik]) {
        skladnikiFiltr=skladniki
        
        var tab:[Danie]=[]
        print (skladnikiFiltr as Any )
        for skladnik in skladniki {
            tab=skladnik.danie?.allObjects as! [Danie]
            if #available(iOS 16.0, *) {
                if daniaFiltr.contains(tab){
                    
                }else{
                    daniaFiltr.append(contentsOf: tab)
                }
            } else {
                
            }
        }
        ifSorted=true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print (daniaFiltr)
    }
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dania: [Danie]=[]
    var daniaFiltr: [Danie]=[]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDanieVC"){
            if let destvc = segue.destination as? danieVC{
                destvc.danie = sender as? Danie
            }
        }
        if(segue.identifier == "toDaniaCategories"){
            if let destVC = segue.destination as? DanieKategorieVC{
                destVC.delegate = self
            }
        }
    }
    
    @IBAction func unwind(_ seg:UIStoryboardSegue){
        
    }
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ifSorted=false
        fetchDanie()

    }
    
    var skladnikiFiltr:[Skladnik]?
    var ifSorted=false
    override func viewDidAppear(_ animated: Bool) {
        fetchDanie()
        
        print("-----------------------")
        print(skladnikiFiltr ?? "eee")
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
        if ifSorted{
            return self.daniaFiltr.count
        }else{
            return self.dania.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "danieCell")else{
          return UITableViewCell()
        }
        if ifSorted{
            cell.textLabel?.text=daniaFiltr[indexPath.row].nazwaPrzepisu
        }else{
            cell.textLabel?.text = dania[indexPath.row].nazwaPrzepisu
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ifSorted{
            performSegue(withIdentifier: "toDanieVC", sender: daniaFiltr[indexPath.row])
        }else{
            performSegue(withIdentifier: "toDanieVC", sender: dania[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
