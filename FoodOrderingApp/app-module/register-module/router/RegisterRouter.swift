//
//  RegisterRouter.swift
//  FoodOrderingApp
//
//  Created by Deniz on 5.04.2022.
//

import Foundation

class RegisterRouter : PresenterToRouterRegisterProtocol
{
    static func createModule(ref: RegisterViewController) {
        ref.registerPresneterObject = RegisterPresenter()
        ref.registerPresneterObject?.registerInteractor = RegisterInteractor()
    }
}

