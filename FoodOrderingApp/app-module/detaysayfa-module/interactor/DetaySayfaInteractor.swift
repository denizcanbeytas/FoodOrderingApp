//
//  DetaySayfaInteractor.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import Foundation
import Alamofire

class DetaySayfaInteractor : PresenterToInteractorDetaySayfaProtocol {
    
    func yemekAdet(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:String, yemek_siparis_adet:String, kullanici_adi:String) {
        
        let params:Parameters = ["yemek_adi":yemek_adi,
                                 "yemek_resim_adi":yemek_resim_adi,
                                 "yemek_fiyat":yemek_fiyat,
                                 "yemek_siparis_adet":yemek_siparis_adet,
                                 "kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).response{ response in
            
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
