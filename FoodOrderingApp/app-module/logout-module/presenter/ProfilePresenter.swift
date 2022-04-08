//
//  ProfilePresenter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 8.04.2022.
//

import Foundation

class ProfilePresenter : ViewToPresenterProfileProtocol {

    var profileInteractor: PresenterToInteractorProfileProtocol?
    var profileView: PresenterToViewProfileProtocol?
    
    func yemekleriYukle() {
        profileInteractor?.tumYemekleriAl()
    }
}

extension ProfilePresenter : InteractorToPresenterProfileProtocol {
    func presenteraVeriGonder(yemekListesi: Array<TumYemekler>) {
        profileView?.vieweVeriGonder(yemekListesi: yemekListesi)
    }
}
