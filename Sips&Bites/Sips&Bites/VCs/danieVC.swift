
import UIKit
import CoreData

enum likedState{
    case liked
    case notliked
}


class danieVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate {
    
    
    
    //MARK: - Outlets and actions
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nazwaD: UILabel!
    @IBOutlet weak var kosztLabel: UILabel!
    @IBOutlet weak var czasLabel: UILabel!
    @IBOutlet weak var profilLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func likeTapped(_ sender: Any) {
        switch likeState {
        case .notliked:
            self.setLiked(sender as! UIButton)
            users[0].addToUlubione(danie!)
        case .liked:
            self.setUnliked(sender as! UIButton)
            users[0].removeFromUlubione(danie!)
        case .none:
            print ("error")
        }
        do{
            try context.save()
        }catch{
            
        }
    }
    
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
    
    


    var users:[Uzytkownik]=[]
    var danieLiked:Bool?
    var likeState:likedState?
    var danie: Danie?
    var skladniki:[Skladnik]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        collectionView.delegate=self
        collectionView.dataSource=self
        textView.delegate=self
        configureTextView()
        textView.text=danie?.sposobPrzygotowania ?? "Błąd"
        //print(danie?.iloscSkladnikow as Any)
        //print(danie?.skladniki as Any)
        skladniki=danie?.skladniki?.array as! [Skladnik]
        print(skladniki.first?.danie as Any)
        nazwaD.text=danie?.nazwaPrzepisu ?? "Błąd"
        kosztLabel.text="Koszt: \(danie?.koszt ?? 0) złotych"
        
        if let czas=danie?.czasPrzygotowania{
            czasLabel.text="Czas przygotowania: \(czas) min"
        }else{
            czasLabel.text="Czas przygotowania niepodany"
        }
        
        profilLabel.text=danie?.profilSmakowy ?? "Profil niepodany"
        
        if let imie=danie!.autor?.imie,let nazwisko=danie?.autor?.nazwisko{
            autorLabel.text=imie+" "+nazwisko
        }else{
            autorLabel.text="Autor niepodany"
        }
        if (users.isEmpty==false){
            danieLiked=users[0].ulubione?.contains(danie as Any)
        }
        switch danieLiked {
        case true:
            setLiked(likeButton)
        case false:
            setUnliked(likeButton)
        case .none:
            setUnliked(likeButton)
        case .some(_):
            setUnliked(likeButton)
        }
        
        
        //print(skladniki)
        
        
        
    }
   
    //MARK: - funkcje pomocnicze
    
    
    func setLiked(_ sender: UIButton){
        UIButton.animate(withDuration: 0.2, animations: {
            sender.transform=CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
        completion: {finish in
            UIButton.animate(withDuration: 0.2, animations: {
                sender.transform=CGAffineTransform.identity
                
            })
        })
        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeState = .liked
        print(sender.currentImage)
    }
    
    func setUnliked(_ sender: UIButton){
        UIButton.animate(withDuration: 0.2, animations: {
            sender.transform=CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
        completion: {finish in
            UIButton.animate(withDuration: 0.2, animations: {
                sender.transform=CGAffineTransform.identity
                
            })
        })
        sender.setImage(UIImage(systemName: "heart"), for: .normal)
        likeState = .notliked
    }
    
    func configureTextView(){
        textView.layer.borderWidth=2
        textView.layer.borderColor=UIColor.lightGray.cgColor
        textView.layer.cornerRadius=5
        
    }
    
    
    //MARK:  - fetch requests
    
    func fetchUser(){
        do{
            self.users=try context.fetch(Uzytkownik.fetchRequest())
        }catch{
            
        }
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


