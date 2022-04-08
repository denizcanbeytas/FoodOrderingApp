//
//  InfoViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 1.04.2022.
//

import UIKit
import Kingfisher
import Firebase

class InfoViewController: UIViewController {

    @IBOutlet weak var infoMarginView: UIView!
    @IBOutlet weak var infoProductNumberTF: UILabel!
    @IBOutlet weak var infoProductNameTF: UILabel!
    @IBOutlet weak var infoProductPriceTF: UILabel!
    @IBOutlet weak var infoProductImage: UIImageView!
    
    @IBOutlet weak var cartFoodSizeView: UIView!
    @IBOutlet weak var cartButtonsView: UIView!
    @IBOutlet weak var cartFoodEnergyView: UIView!
    @IBOutlet weak var cartFoodDeliveryView: UIView!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    let userDefault = UserDefaults.standard
    var yemek:TumYemekler?
    var detaySayfaPresenterNesnesi:ViewToPresenterDetaySayfaProtocol?
    
    var adet = 1
    var toplam = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToCartBtn.layer.cornerRadius = 10
        
        cartFoodDeliveryView.layer.borderWidth = 1
        cartFoodDeliveryView.layer.cornerRadius = 10
        cartFoodDeliveryView.layer.borderColor = UIColor.orange.cgColor
        
        cartFoodEnergyView.layer.borderWidth = 1
        cartFoodEnergyView.layer.cornerRadius = 10
        cartFoodEnergyView.layer.borderColor = UIColor.orange.cgColor
        
        cartFoodSizeView.layer.borderWidth = 1
        cartFoodSizeView.layer.cornerRadius = 10
        cartFoodSizeView.layer.borderColor = UIColor.orange.cgColor
        
        infoMarginView.layer.cornerRadius = 40
        
        cartButtonsView.layer.cornerRadius = 20
        
        if let y = yemek {
            infoProductImage.image = UIImage(named: y.yemek_resim_adi!)
            infoProductNameTF.text = "\(y.yemek_adi!)"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi!)") {
                DispatchQueue.main.async {
                    self.infoProductImage.kf.setImage(with: url)
                }
            }
            infoProductPriceTF.text = "\(y.yemek_fiyat!) TL"
        }
        DetaySayfaRouter.createModule(ref: self)
        
        // tabbar ı info dan sildik -1
        self.tabBarController?.tabBar.isHidden = true
    }
    // tabbar ı info dan sildik -2
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func infoAddClicked(_ sender: Any) {
        if let k = infoProductNumberTF.text,let y = yemek{
            detaySayfaPresenterNesnesi?.adet(yemek_adi: y.yemek_adi!, yemek_resim_adi: y.yemek_resim_adi!, yemek_fiyat: y.yemek_fiyat!, yemek_siparis_adet: k, kullanici_adi: "\(Auth.auth().currentUser?.email ?? "")")
            
        }
        if let y = yemek {
            print("\(y.yemek_adi!) - \(infoProductNumberTF.text!) adet \(infoProductPriceTF.text!) fiyatla sepete eklendi.")
        }
        
        // home ekranına geri dönüldü
        navigationController?.popViewController(animated: true)
    }

    @IBAction func infoPlusClicked(_ sender: Any) {
  
        adet += 1
        
        if let b = yemek?.yemek_fiyat! {
            if let a = Int(b){
                toplam = a * adet
                infoProductPriceTF.text = "\(toplam) TL"
            }
            
        }
        
        infoProductNumberTF.text = String(adet)
    }
    
    @IBAction func infoMinesClicked(_ sender: Any) {
        
        if adet > 1 {
            adet -= 1
        }
        if let b = yemek?.yemek_fiyat! {
            if let a = Int(b){
                infoProductPriceTF.text = "\(a * adet) TL"
            }
        }
        infoProductNumberTF.text = String(adet)
    }
}
