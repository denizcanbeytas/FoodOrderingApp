//
//  SepetSayfaInteractor.swift
//  FoodOrderingApp
//
//  Created by Deniz on 1.04.2022.
//

import Foundation
import Alamofire

class SepetSayfaInteractor : PresenterToInteractorSepetSayfaProtocol {
    
    var sepetSayfaPresenter: InteractorToPresenterSepetSayfaProtocol?
    
    func sepettekiYemekleriAl(kullanici_adi:String) {
        
        let params : Parameters = ["kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{ response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    var liste = [SepetYemekler]()
                    if let gelenListe = cevap.sepet_yemekler {
                        liste = gelenListe
                    }
                    self.sepetSayfaPresenter?.presenteraVeriGonder(sepetYemeklerListe: liste)
                }catch let error {
                    print(error.localizedDescription)
                    self.sepetSayfaPresenter?.presenteraVeriGonder(sepetYemeklerListe: [])
                }
            }
        }
    }
    
    func yemekSil(sepet_yemek_id: String,kullanici_adi:String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post,parameters:   params).response { response in
            if let data = response.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                        self.sepettekiYemekleriAl(kullanici_adi:kullanici_adi)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
