
import UIKit
import CoreData

enum likedState{
    case liked
    case notliked
}


class danieVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate {
    
    func exportToUrl(string: String)->URL?{
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let path = documents?.appendingPathComponent("danie.txt")
        do {
            try string.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch{
            
        }
        return path ?? nil
        
    }
    
    
    func convertToString(danie:Danie)->String{
        let nazwa = danie.nazwaPrzepisu ?? "brak nazwy"
        let opis=danie.sposobPrzygotowania ?? "brak opisu"
        let profil=danie.profilSmakowy ?? "brak profilu"
        let koszt=String(danie.koszt)
        let czas=String(danie.czasPrzygotowania)
        let autor=(danie.autor?.imie ?? "") + " " + (danie.autor?.nazwisko ?? "")
        var listaskladnikow=""
        let listailosciskladnikow = danie.iloscSkladnikow
        var i=0
        for skladnik in skladniki{
            listaskladnikow = listaskladnikow + " " + (skladnik.nazwaSkladnika ?? "") + "-"+listailosciskladnikow![i]+";;"
            i+=1
        }
        let danieZestringowane = """
        &*&\(String(describing: nazwa))&*&
        Koszt: &*&\(koszt)&*& zł  Czas Wykonania: &*&\(czas)&*& Profil smakowy &*&\(profil)&*&
        Autor: &*&\(autor)&*&
        &&&&&&&&
        &*&\(listaskladnikow)&*&
        
        *****
        
        &*&\(String(describing: opis))&*&
        
        
        
        E*N*D
        """
        return danieZestringowane
    }
    
    //MARK: - Outlets and actions
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nazwaD: UILabel!
    @IBOutlet weak var kosztLabel: UILabel!
    @IBOutlet weak var czasLabel: UILabel!
    @IBOutlet weak var profilLabel: UILabel!
    @IBOutlet weak var ocenaLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var ocenaEdit: UIStepper!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func shareTapped(_ sender: Any) {
        
        
        let objectstoshare=[exportToUrl(string: convertToString(danie: danie!))]
        let activityVC = UIActivityViewController(activityItems: objectstoshare as [Any], applicationActivities: nil)
        activityVC.excludedActivityTypes=[UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true)
        
    }
    
    @IBAction func ocenaChanged(_ sender: Any) {
        danie?.ocena=Int64(ocenaEdit.value)
        ocenaLabel.text=String(Int64(ocenaEdit.value))
        do{
            try context.save()
        }catch{
            
        }
    }
    
    
    
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
    
    

    //MARK: - zmienne
    var users:[Uzytkownik]=[]
    var danieLiked:Bool?
    var likeState:likedState?
    var danie: Danie?
    var skladniki:[Skladnik]=[]
    var ocena:Int64?
    //MARK: - DidLoad
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
        likeButtonConfig()
        shareButtonConfig()
        
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
    func shareButtonConfig(){
        shareButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 43), forImageIn: .normal)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setTitle("", for: .normal)
    }
    func likeButtonConfig(){
        likeButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 45), forImageIn: .normal)
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
        if let ocena=danie?.ocena{
            ocenaEdit.value=Double(ocena)
            ocenaLabel.text=String(ocena)
        }
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


