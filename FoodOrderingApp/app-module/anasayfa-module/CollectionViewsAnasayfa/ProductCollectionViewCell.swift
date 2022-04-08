//
//  CollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Deniz on 1.04.2022.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productColProductNameLabel: UILabel!
    @IBOutlet weak var productColProductPriceLabel: UILabel!
    @IBOutlet weak var productColView: UIView!
    @IBOutlet weak var productColImage: UIImageView!
    
    @IBOutlet weak var productBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productColView.layer.borderWidth = 0.5
        productColView.layer.borderColor = UIColor.systemGray4.cgColor
        productColView.layer.cornerRadius = 10
    }
    
    func resimGoster(resimAdi:String){
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)"){
            
            DispatchQueue.main.async { //kingfisher kullanımı
                
                self.productColImage.kf.setImage(with: url)
                
            }
        }
    }

}
