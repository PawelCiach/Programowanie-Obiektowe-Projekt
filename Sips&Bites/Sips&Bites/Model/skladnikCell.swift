//
//  skladnikCell.swift
//  Sips&Bites
//
//  Created by Maciej Bichajło on 12/12/2022.
//

import UIKit

class skladnikCell:UICollectionViewCell{
   
    @IBOutlet weak var nazwa: UILabel!
    

    override func layoutSubviews() {
        self.layer.cornerRadius=15.0
        
        
    }
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    public func configure(with skladnik:Skladnik,and ilosc:String) {
        nazwa.text = skladnik.nazwaSkladnika! + " - " + ilosc
    }
    
    
    
}
