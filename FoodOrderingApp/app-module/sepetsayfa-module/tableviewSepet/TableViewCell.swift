//
//  TableViewCell.swift
//  FoodOrderingApp
//
//  Created by Deniz on 1.04.2022.
//

import UIKit
import Kingfisher

protocol TableViewCellDelegate : AnyObject {
    func didTapMinesBtnFromUser(_ cell: TableViewCell)
    func didTapPlusBtnFromUser(_ cell: TableViewCell)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var basketProductImage: UIImageView!
    @IBOutlet weak var basketProductName: UILabel!
    @IBOutlet weak var basketProductPrice: UILabel!
    @IBOutlet weak var basketProductNumber: UILabel!
    @IBOutlet weak var BtnView: UIView!
    
    @IBOutlet weak var minesBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    weak var delegate : TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureButtons()
        
        BtnView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configureButtons() {
        minesBtn.addTarget(self, action: #selector(didTapMinesBtn), for: .touchUpInside)
        plusBtn.addTarget(self, action: #selector(didTapPlusBtn), for: .touchUpInside)
    }
    
    @objc func didTapMinesBtn() {
        delegate?.didTapMinesBtnFromUser(self)
    }
    
    @objc func didTapPlusBtn(){
        delegate?.didTapPlusBtnFromUser(self)
    }
    
    
}
