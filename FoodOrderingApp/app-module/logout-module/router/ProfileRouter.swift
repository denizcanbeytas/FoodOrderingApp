//
//  ProfileRouter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 8.04.2022.
//

import Foundation

class ProfileRouter : PresenterToRouterProfileProtocol {
    static func createModule(ref: ProfileViewController) {
        
        let presenter : ViewToPresenterProfileProtocol & InteractorToPresenterProfileProtocol = ProfilePresenter()
        
        //View controller için
        ref.profilePresenterNesnesi = presenter
        
        //Presenter için
        ref.profilePresenterNesnesi?.profileInteractor = ProfileInteractor()
        ref.profilePresenterNesnesi?.profileView = ref
        
        //Interactor için
        ref.profilePresenterNesnesi?.profileInteractor?.profilePresenter = presenter
        
    }
}
