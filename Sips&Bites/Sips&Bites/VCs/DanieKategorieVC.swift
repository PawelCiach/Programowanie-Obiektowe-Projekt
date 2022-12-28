//
//  DanieKategorieVC.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 19/12/2022.
//

import UIKit
import CoreData

protocol Filtr:AnyObject{
    func filtrSkladnik(_ skladniki:[Skladnik])
    
    
}

class DanieKategorieVC:
    UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==tableView1{
            return skladnikiAll.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView==tableView1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterSkladnikiCell") else{
                return UITableViewCell()
            }
            cell.textLabel?.text=skladnikiAll[indexPath.row].nazwaSkladnika
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView==tableView1{
            skladnikiFilt.append(skladnikiAll[indexPath.row])
        }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        if tableView==tableView1{
            skladnikiFilt.removeAll(where: {$0 == skladnikiAll[indexPath.row]})
        }

    }
    
    
    
    

    @IBAction func filtrujTapped(_ sender: Any) {
        delegate?.filtrSkladnik(skladnikiFilt)
        dismiss(animated: true)        //performSegue(withIdentifier: "backToDaniaVC", sender: skladnikiFilt)
    }
    
    @IBOutlet weak var tableView1: UITableView!
    weak var delegate: Filtr?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToDaniaVC"){
            if let destvc=segue.destination as? daniaVC{
                destvc.skladnikiFiltr=sender as? [Skladnik]
            }
        }
    }
    
    var skladnikiAll:[Skladnik]=[]
    var skladnikiFilt:[Skladnik]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.dataSource=self
        tableView1.delegate=self
        self.tableView1.allowsMultipleSelection=true
        fetchSkladniki()

        // Do any additional setup after loading the view.
    }
    
    
    func fetchSkladniki(){
        do{
            self.skladnikiAll=try context.fetch(Skladnik.fetchRequest())
            DispatchQueue.main.async {
                self.tableView1.reloadData()
            }
        }catch{
            
        }
    }
    

  

}


