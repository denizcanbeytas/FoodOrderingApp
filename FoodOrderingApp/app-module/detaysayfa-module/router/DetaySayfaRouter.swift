//
//  DetaySayfaRouter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import Foundation

class DetaySayfaRouter : PresenterToRouterDetaySayfaProtocol {
    static func createModule(ref: InfoViewController) {
        ref.detaySayfaPresenterNesnesi = DetaySayfaPresenter()
        ref.detaySayfaPresenterNesnesi?.detaySayfaInteractor = DetaySayfaInteractor()
    }
}
