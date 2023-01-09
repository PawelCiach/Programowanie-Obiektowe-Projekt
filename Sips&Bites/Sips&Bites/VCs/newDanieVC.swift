//
//  newDanieVC.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 07/12/2022.
//

import UIKit
import CoreData

class newDanieVC: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextViewDelegate{
    
    //MARK: - outlets and actions
    
    
    @IBAction func dodajPrzepisTapped(_ sender: Any) {
        print(self.metoda.text!)
        let noweDanie=Danie(context: context)
        noweDanie.iloscSkladnikow=ilosciSkl
        for skladnik in skladnikiAkt{
            noweDanie.addToSkladniki(skladnik)
            //skladnik.addToDanie(noweDanie)
        }
        noweDanie.nazwaPrzepisu=nazwaDania.text
        noweDanie.koszt=koszt ?? 0
        noweDanie.czasPrzygotowania=czas ?? 0
        noweDanie.profilSmakowy=profil.text ?? ""
        
        do{
            try self.context.save()
        }
        catch{
            let alert=UIAlertController(title: "Błąd", message: "Błąd zapisu", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        }
        performSegue(withIdentifier: "backToDaniaVC", sender: self)
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var czasField: UITextField!
    
    
    @IBAction func czas(_ sender: Any) {
        self.czas=Int64(czasField.text ?? "0") ?? 0
    }
    
    
    @IBOutlet weak var profil: UITextField!
    
    
  
    
    
    @IBOutlet weak var kosztField: UITextField!
    
    @IBAction func koszt(_ sender: Any) {
        self.koszt=Int64(kosztField.text ?? "0") ?? 0
    }
    
    
    @IBAction func addSkladnikTapped(_ sender: Any) {
        showAlert()
    }
    
    func configureTextView(){
        metoda.layer.borderWidth=2
        metoda.layer.borderColor=UIColor.lightGray.cgColor
        metoda.layer.cornerRadius=5
        
    }
    
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Dodaj wlasny skladnik", message: "Jesli nie znalazłeś na liście", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Nieważne", style: .cancel,handler: {action in
            self.collectionView.reloadData()
        }))
        
        
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Dodaj", style: .default,handler: {[weak alert] (_) in
            let textField = alert?.textFields![0]
            
            let skladnikNowy = Skladnik(context: self.context)
            skladnikNowy.nazwaSkladnika=textField?.text
            
            do{
                try self.context.save()
            }
            catch{
            }
            
            //self.skladnikiAkt.append(skladnikCellModel(name: (textField?.text)!, ilosc: "2"))
            self.collectionView.reloadData()
            
        }))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return szukaneSkl.count
        }else{
            return wszystkieSkl.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "szukajSkladnikCell") else{
            return UITableViewCell()
        }
        if searching{
            cell.textLabel?.text=szukaneSkl[indexPath.row].nazwaSkladnika
        }else{
            cell.textLabel?.text=wszystkieSkl[indexPath.row].nazwaSkladnika
        }
        
        return cell
    }
    
    func fetchSkladniki(){
        do{
            self.wszystkieSkl=try context.fetch(Skladnik.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Tablice i zmiene
    
    var skladnikiAkt:[Skladnik]=[]
    
    var wszystkieSkl:[Skladnik]=[]
    
    var szukaneSkl:[Skladnik]=[]
    var searching=false
    
    var ilosciSkl:[String]=[]
    var koszt:Int64?
    var czas:Int64?
    var profilSmakowy:String?

    @IBOutlet weak var nazwaDania: UITextField!
    
    
    @IBOutlet weak var metoda: UITextView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
//MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        nazwaDania.delegate=self
        collectionView.dataSource=self
        collectionView.delegate=self
        tableView.dataSource=self
        tableView.delegate=self
        tableView.isHidden=true
        searchBar.delegate=self
        metoda.delegate=self
        
        fetchSkladniki()
        print(wszystkieSkl)
        collectionView.isHidden=false
        configureTextView()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(newDanieVC.tap(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.cancelsTouchesInView=false
    }
  
    @objc func tap(_ sender:UITapGestureRecognizer){
        view.endEditing(true)
        //tableView.isHidden=true
    }
    
    //MARK: - search bar
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        szukaneSkl=wszystkieSkl.filter{$0.nazwaSkladnika!.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching=true
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton=true
        fetchSkladniki()
        tableView.isHidden=false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searching=false
        tableView.isHidden=true
        searchBar.text=""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton=false
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.context.delete(wszystkieSkl[indexPath.row])
        alertSkladnik(with: wszystkieSkl[indexPath.row])
        do{
            try self.context.save()
        }
        catch{
            
        }
    }

    
    func alertSkladnik(with skladnik:Skladnik){
        
        let alert = UIAlertController(title: "Podaj ilosc", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Nieważne", style: .cancel,handler: {action in
            self.collectionView.reloadData()
            self.tableView.isHidden=true
        }))
        alert.addAction(UIAlertAction(title: "Usun z listy", style: .destructive,handler: {action in
            self.context.delete(skladnik)
            do{
                try self.context.save()
                
            }
            catch{
                
            }
            self.fetchSkladniki()
        }))
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Dodaj", style: .default,handler: {[weak alert] (_) in
            let textField = alert?.textFields![0]
            
            self.skladnikiAkt.append(skladnik)
            self.ilosciSkl.append((textField?.text)!)
            
            //self.skladnikiAkt.append(skladnikCellModel(name: (textField?.text)!, ilosc: "2"))
            self.collectionView.reloadData()
            self.tableView.isHidden=true
            
        }))
        searchBar.resignFirstResponder()
        present(alert, animated: true)
        
        
    }

   

}

extension newDanieVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.skladnikiAkt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skladnikCell", for: indexPath) as? skladnikCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: skladnikiAkt[indexPath.row], and: ilosciSkl[indexPath.row])
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth=1
        cell.layer.borderColor=UIColor.clear.cgColor
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let label = UILabel(frame: CGRect.zero)
        //label.text = skladnikiAkt[indexPath.row].name+" - "+skladnikiAkt[indexPath.row].ilosc
        //label.sizeToFit()
        //return CGSize(width: skladnikiAkt[indexPath.row].name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 30)
        collectionView.layer.borderWidth=3
        collectionView.layer.backgroundColor=UIColor.lightGray.cgColor
        collectionView.layer.borderColor=UIColor.darkGray.cgColor
        collectionView.layer.cornerRadius=7
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skladnikCell", for: indexPath) as! skladnikCell
        cell.configure(with: skladnikiAkt[indexPath.row], and: ilosciSkl[indexPath.row])
        return CGSize(width:cell.nazwa.text!.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 8 , height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        skladnikiAkt.remove(at: indexPath.row)
        ilosciSkl.remove(at: indexPath.row)
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
}




    

