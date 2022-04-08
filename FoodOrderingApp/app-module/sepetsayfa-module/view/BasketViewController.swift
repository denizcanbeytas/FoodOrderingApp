//
//  BasketViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 1.04.2022.
//

import UIKit
import Kingfisher
import Firebase

class BasketViewController: UIViewController {

    @IBOutlet weak var basketTableView: UITableView! //sepatSayfaTableView
    @IBOutlet weak var basketSumPriceLabel: UILabel! // toplamLabel
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var paymentBtn: UIButton!
    
    var basketCell : TableViewCell?
    var adet = 1
    var yemek:TumYemekler?
    var toplamSepet = 0
    var textToplam : Int = 0
    
    var toplam : Int = 0
    var sepetSayfaPresenterNesnesi:ViewToPresenterSepetSayfaProtocol?
    var yemekler = [SepetYemekler]()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentBtn.layer.cornerRadius = 10
        locationView.layer.cornerRadius = 30
        
        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        SepetSayfaRouter.createModule(ref: self)
    }
    
    @IBAction func basketPaymentClicked(_ sender: Any) {
        print("\(basketSumPriceLabel.text!) ile sepet onaylandı. ")
        toggleNavigation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let kullaniciAdi = "\(Auth.auth().currentUser?.email ?? "")"
        sepetSayfaPresenterNesnesi?.yemekleriAl(kullanici_adi:"\(Auth.auth().currentUser?.email ?? "")")
        get_total()
        
    }
    
    @IBAction func deleteAllClick(_ sender: Any) {
        toggleDeleteAll()
        //silBarButton()
    }
    
    func silBarButton(){
        for yemek in yemekler {
            sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
        }
    }
    
    func get_total(){
        var total = 0

        for yemek in yemekler {
            total += Int(yemek.yemek_siparis_adet!)! * Int(yemek.yemek_fiyat!)!
        
        }
        basketSumPriceLabel.text = "\(String(total)) TL"
        
    }
    
    @objc func cellDeleteBtn(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        print(index.row)
        let yemek = yemekler[index.row]
        
        let alert = UIAlertController(title: "Do you want to delete '\(yemek.yemek_adi!)' in the cart?", message: "", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Delete \(yemek.yemek_adi!)", style: .destructive){ [weak self] action in
            self!.sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
        }
        alert.addAction(tamamAction)
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
            
        }
        alert.addAction(iptalAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

extension BasketViewController : PresenterToViewSepetSayfaProtocol {
    func vieweVeriGonder(sepetYemeklerListe:Array<SepetYemekler>) {
        self.yemekler = sepetYemeklerListe
        
        DispatchQueue.main.async {
            self.basketTableView.reloadData()
            self.get_total()
        }
    }

}

extension BasketViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //basketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as? TableViewCell
        let yemek = yemekler[indexPath.row]
        let hucre = basketTableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! TableViewCell
        hucre.selectionStyle = .none
        
        hucre.delegate = self
        
        hucre.basketProductName.text = yemek.yemek_adi!
        hucre.basketProductNumber.text = "\(yemek.yemek_siparis_adet!)"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                hucre.basketProductImage.kf.setImage(with: url)
            }
        }
        
        toplam = Int(yemek.yemek_siparis_adet!)! * Int(yemek.yemek_fiyat!)!
        hucre.basketProductPrice.text = "\(toplam) TL"
        
        // sepetteki ürünün deleteBtn'si için
        hucre.deleteBtn.addTarget(self, action: #selector(cellDeleteBtn), for: .touchUpInside)
        hucre.deleteBtn.tag = indexPath.row

        hucre.selectionStyle = .none
        
        return hucre
        
        
    }
    
    // Hücredeki veriyi silme
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction,view,bool) in
            
            let yemek = self.yemekler[indexPath.row]
            
            
            let alert = UIAlertController(title: "\(yemek.yemek_adi!) delete from cart?", message: "", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
                
            }
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                self.sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension BasketViewController {
    // MARK: - Toggle Fonksiyonları
    
    // Sepet onayladıktan sonra çıkan toggle
    func toggleNavigation() {
        let alert = UIAlertController(title: "Your order has been confirmed.", message: "Thank you for your order.", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Ok", style: .default){ [weak self] action in
            // ürünler silindi
            for yemek in self!.yemekler {
                self!.sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id: yemek.sepet_yemek_id!, kullanici_adi: yemek.kullanici_adi!)
            }
          
//            DispatchQueue.main.async {
//
//            }
            self?.tabBarController?.selectedIndex = 0
            
        }
        alert.addAction(tamamAction)
        present(alert, animated: true, completion: nil)

    }
    
    // Sepetteki tüm ürünleri silerken çıkan toggle
    func toggleDeleteAll() {
        let alert = UIAlertController(title: "Do you want to delete all items in the cart?", message: "", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Delete All", style: .destructive){ [weak self] action in
            //_ = self?.navigationController?.popToRootViewController(animated: true)
            self?.silBarButton()
        }
        alert.addAction(tamamAction)
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
            
        }
        alert.addAction(iptalAction)
        present(alert, animated: true, completion: nil)

    }
    
}

extension BasketViewController : TableViewCellDelegate {
    func didTapPlusBtnFromUser(_ cell: TableViewCell) {
        let indexPath =  basketTableView.indexPath(for: cell)
        let siparisAdet = Int(yemekler[indexPath!.row].yemek_siparis_adet!)! + 1
        print(siparisAdet)
        
        yemekler[indexPath!.row].yemek_siparis_adet = String(siparisAdet)
        basketTableView.reloadData()
        get_total()
    }
    
    func didTapMinesBtnFromUser(_ cell: TableViewCell) {
        let indexPath =  basketTableView.indexPath(for: cell)
        let siparisAdet = Int(yemekler[indexPath!.row].yemek_siparis_adet!)! - 1
        
        if siparisAdet > 0 {
            yemekler[indexPath!.row].yemek_siparis_adet = String(siparisAdet)
        } else {
                sepetSayfaPresenterNesnesi?.sil(sepet_yemek_id:yemekler[indexPath!.row].sepet_yemek_id!, kullanici_adi: yemekler[indexPath!.row].kullanici_adi!)

        }
        
        //let basketCell = basketTableView.cellForRow(at: indexPath!) as! TableViewCell
        basketTableView.reloadData()
        get_total()
  
    }
  
}
