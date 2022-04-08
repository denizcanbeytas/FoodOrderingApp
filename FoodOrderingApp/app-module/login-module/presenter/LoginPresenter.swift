//
//  LoginPresenter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import Foundation

class LoginPresenter : ViewToPresenterLoginProtocol
{
    var loginInteractor: PresenterToInteractorLoginProtocol?
    
    func loginUser(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
    
}
