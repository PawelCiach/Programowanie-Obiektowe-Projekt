
import UIKit
import CoreData

class danieVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    


   
    
    var danie: Danie?
    var skladniki:[Skladnik]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
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

extension danieVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.skladniki.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skladnikDanieCell", for: indexPath) as? skladnikCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: skladniki[indexPath.row], and: (danie?.iloscSkladnikow![indexPath.row])!)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skladnikDanieCell", for: indexPath) as! skladnikCell
        cell.configure(with: skladniki[indexPath.row], and: (danie?.iloscSkladnikow![indexPath.row])!)
        return CGSize(width:cell.nazwa.text!.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 8 , height: 30)
    }
}


