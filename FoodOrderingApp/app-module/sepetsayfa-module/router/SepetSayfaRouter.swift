//
//  SepetSayfaRouter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 1.04.2022.
//

import Foundation

class SepetSayfaRouter : PresenterToRouterSepetSayfaProtocol {
    static func createModule(ref: BasketViewController) {

        let presenter : ViewToPresenterSepetSayfaProtocol & InteractorToPresenterSepetSayfaProtocol = SepetSayfaPresenter()

        ref.sepetSayfaPresenterNesnesi = presenter

        ref.sepetSayfaPresenterNesnesi?.sepetSayfaInteractor = SepetSayfaInteractor()
        ref.sepetSayfaPresenterNesnesi?.sepetSayfaView = ref

        ref.sepetSayfaPresenterNesnesi?.sepetSayfaInteractor?.sepetSayfaPresenter = presenter

    }
}
