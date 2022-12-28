
import UIKit
import CoreData

class cocktaileVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var cocktaile: [Cocktail] = []
   
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCocktailVC"){
            if let destVC = segue.destination as? cocktailVC{
                destVC.activeCk = sender as? Cocktail
            }
                
        }
    }
    
    @IBAction func unwind(_ seg:UIStoryboardSegue){
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCocktail()
    }
    override func viewDidAppear(_ animated: Bool) {
            fetchCocktail()
        }
    
    @IBAction func cocktailsCategoriesButton(_ sender: Any) {
        performSegue(withIdentifier: "toCocktailsCategories", sender: nil)
    }
    @IBAction func newCocktailButton(_ sender: Any) {
        performSegue(withIdentifier: "toNowyCocktail", sender: nil)
    }
    func fetchCocktail(){
        do{
            self.cocktaile = try context.fetch(Cocktail.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
}

extension cocktaileVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cocktaile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell")else{
            return UITableViewCell()
        }
        let cocktail = self.cocktaile[indexPath.row]
        cell.textLabel?.text = cocktail.nazwaPrzepisu
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCocktailVC", sender: cocktaile[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

