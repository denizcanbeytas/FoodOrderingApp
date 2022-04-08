//
//  ProfileProtocols.swift
//  FoodOrderingApp
//
//  Created by Deniz on 8.04.2022.
//

import Foundation

protocol ViewToPresenterProfileProtocol {
    var profileInteractor:PresenterToInteractorProfileProtocol? {get set}
    var profileView:PresenterToViewProfileProtocol? {get set}
    
    func yemekleriYukle()
    
}

protocol PresenterToInteractorProfileProtocol {
    var profilePresenter:InteractorToPresenterProfileProtocol? {get set}
    
    func tumYemekleriAl()
    
}

protocol InteractorToPresenterProfileProtocol {
    func presenteraVeriGonder(yemekListesi:Array<TumYemekler>)
}

protocol PresenterToViewProfileProtocol {
    func vieweVeriGonder(yemekListesi:Array<TumYemekler>)
}

protocol PresenterToRouterProfileProtocol {
    static func createModule(ref:ProfileViewController)
}
