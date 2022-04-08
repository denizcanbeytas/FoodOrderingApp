//
//  ViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 31.03.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var homeSearchTextField: UITextField!
    @IBOutlet weak var searcTextView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var productCollectionCell:ProductCollectionViewCell!
    var categoriesCollectionCell:CategoriesCollectionViewCell!
    
    var yemekListe = [TumYemekler]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    var filterFoodList = [TumYemekler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Collection Views Delegates
        productCollectionView.register(UINib(nibName:"ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productColCell")
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        categoriesCollectionView.register(UINib(nibName:"CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoriesColCell")
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        //
 
        navigationController?.navigationBar.barStyle = .default

        let a = UITabBarAppearance()
        a.backgroundColor = UIColor.white
     
        AnasayfaRouter.createModule(ref: self)
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yemekleriYukle()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let yemek = sender as? TumYemekler
            let gidilecekVC = segue.destination as! InfoViewController
            gidilecekVC.yemek = yemek
        }
    }
    
}

extension HomeViewController : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemekListesi: Array<TumYemekler>) {
        self.yemekListe = yemekListesi
        self.filterFoodList = yemekListesi
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
}

// SEARCH
extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterFoodList = self.yemekListe.filter{yemek in
            if yemek.yemek_adi!.lowercased().contains(searchText.lowercased()){
                return true
            }
            if searchText == ""{
                return true
            }
            return false
        }
        self.productCollectionView.reloadData()
        
        anasayfaPresenterNesnesi?.ara(aramaKelimesi: searchText)
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoriesCollectionView {
        
            return 12
        } else {

            return filterFoodList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoriesCollectionView {
            return CGFloat(0)
        } else {
            return CGFloat(15)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView {
            categoriesCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesColCell", for: indexPath) as? CategoriesCollectionViewCell
            
            return categoriesCollectionCell!
        } else {
            productCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productColCell", for: indexPath) as? ProductCollectionViewCell
            let yemek = filterFoodList[indexPath.row]
            let hucre = productCollectionCell
            
            hucre?.productColImage.image = UIImage(named: yemek.yemek_resim_adi!)
            hucre?.productColProductNameLabel.text = yemek.yemek_adi
            hucre?.productColProductPriceLabel.text = "\(yemek.yemek_fiyat!) TL"
            
            
            hucre?.resimGoster(resimAdi: "\(yemek.yemek_resim_adi!)")
            
    
            return hucre!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            return CGSize(width: CGFloat(160), height: CGFloat(45))
        } else {
            return CGSize(width: CGFloat(202), height: CGFloat(241))
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCollectionView {
            print("Girdi")
            let yemek = filterFoodList[indexPath.row]
            performSegue(withIdentifier: "toDetay", sender: yemek)
            //collectionView.deselectRow(at: indexPath, animated: true)
        } else {
            print("Hata")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == productCollectionCell {
            return UIEdgeInsets(top: CGFloat(0), left: CGFloat(5), bottom: CGFloat(20), right: CGFloat(5))
        } else {
            return UIEdgeInsets(top: CGFloat(0), left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
        }

    }
    

}
