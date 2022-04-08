//
//  ProfilViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 6.04.2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    var profileCollectionViewCell:ProfileCollectionViewCell!
    var yemekListe = [TumYemekler]()
    var filterFoodList = [TumYemekler]()
    var profilePresenterNesnesi:ViewToPresenterProfileProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileCollectionView.register(UINib(nibName:"ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "profilColCell")
        profileCollectionView.dataSource = self
        profileCollectionView.delegate = self
        
        uiDesign()
        ProfileRouter.createModule(ref: self)
        
        
    }
    
    func uiDesign(){
        searchView.layer.cornerRadius = 10
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.black.cgColor
        
        profileView.layer.cornerRadius = 10
       // profileView.layer.borderWidth = 1
        //profileView.layer.borderColor = UIColor.black.cgColor
        
        contentView.layer.cornerRadius = 40
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profilePresenterNesnesi?.yemekleriYukle()
        showInfo()
    }
    
    func showInfo() {
        let auth = Auth.auth()
        
        let email = (auth.currentUser?.email)!
        //let userName = (auth.currentUser?.userName)!
      
        emailLabel.text = email
        //userNameLabel.text =
    }


    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        }
        catch { print("error") }
    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "welcomeVC") as! WelcomeViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: true, completion: nil)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "welcomeVC")
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true)
        
//        let vc = self.storyboard!.instantiateViewController(withIdentifier: "welcomeVC")
//        self.showDetailViewController(vc as! WelcomeViewController, sender: self)
        
        
          
    }
    
}

extension ProfileViewController : PresenterToViewProfileProtocol {
    func vieweVeriGonder(yemekListesi: Array<TumYemekler>) {
        self.yemekListe = yemekListesi
        self.filterFoodList = yemekListesi
        DispatchQueue.main.async {
        self.profileCollectionView.reloadData()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return filterFoodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return CGFloat(20)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            profileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilColCell", for: indexPath) as? ProfileCollectionViewCell
            let yemek = filterFoodList[indexPath.row]
            let hucre = profileCollectionViewCell
            
//            hucre?.productColImage.image = UIImage(named: yemek.yemek_resim_adi!)
            hucre?.profileColImage.image = UIImage(named: yemek.yemek_resim_adi!)
//            hucre?.productColProductNameLabel.text = yemek.yemek_adi
//            hucre?.productColProductPriceLabel.text = "\(yemek.yemek_fiyat!) TL"
//
//
            hucre?.resimGoster(resimAdi: "\(yemek.yemek_resim_adi!)")
            
    
            return hucre!
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            return CGSize(width: CGFloat(178), height: CGFloat(218))
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! InfoViewController
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .overFullScreen
//        self.present(nav, animated: true, completion: nil)
//
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: CGFloat(0), left: CGFloat(15), bottom: CGFloat(20), right: CGFloat(5))
    }
    

}
