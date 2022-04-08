//
//  CategoriesCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Deniz on 1.04.2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoriesCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoriesCellView.layer.borderWidth = 1
        categoriesCellView.layer.borderColor = UIColor.orange.cgColor
        categoriesCellView.layer.cornerRadius = 10
    }

}
