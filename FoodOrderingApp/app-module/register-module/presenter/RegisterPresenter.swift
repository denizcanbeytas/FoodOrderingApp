//
//  RegisterPresenter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 5.04.2022.
//

import Foundation

class RegisterPresenter : ViewToPresenterRegisterProtocol
{
    var registerInteractor: PresenterToInteractorRegisterProtocol?
    
    func registerUser(email: String, password: String) {
        registerInteractor?.register(email: email, password: password)
    }
    
}
