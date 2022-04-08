//
//  LoginRouter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import Foundation

class LoginRouter : PresenterToRouter
{
    static func createModule(ref: LoginViewController) {
        ref.loginPresenterObject = LoginPresenter()
        ref.loginPresenterObject?.loginInteractor = LoginInteractor()
    }
    
}
