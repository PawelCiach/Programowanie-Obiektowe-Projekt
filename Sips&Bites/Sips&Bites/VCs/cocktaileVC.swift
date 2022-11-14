

import UIKit

class cocktaileVC: UIViewController {

    var cocktaile: [String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension cocktaileVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktaile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell")else{
            return UITableViewCell()
        }
        cell.textLabel!.text = cocktaile[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCocktailVC", sender: nil)
    }
}
