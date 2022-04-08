//
//  ProfileCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Deniz on 8.04.2022.
//

import UIKit
import Kingfisher

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var profileColImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func resimGoster(resimAdi:String){
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)"){
            
            DispatchQueue.main.async { //kingfisher kullanımı
                
                self.profileColImage.kf.setImage(with: url)
                
            }
        }
    }

}
