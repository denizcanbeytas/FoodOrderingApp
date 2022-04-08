//
//  AnasayfaInteractor.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import Foundation
import Alamofire

class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriAl() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response{ response in
            
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(TumYemeklerCevap.self, from: data)
                    var liste = [TumYemekler]()
                    if let gelenListe = cevap.yemekler {
                        liste = gelenListe
                    }
                    
                    self.anasayfaPresenter?.presenteraVeriGonder(yemekListesi: liste)
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
    
    func yemekAra(aramaKelimesi: String) {
        print("Arama sonucu : \(aramaKelimesi)")
    }
    
}
