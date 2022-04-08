//  RegisterProtocol.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import Foundation

protocol ViewToPresenterRegisterProtocol
{
    var registerInteractor : PresenterToInteractorRegisterProtocol? {get set}
    
    func registerUser(email : String, password : String)
}

protocol PresenterToInteractorRegisterProtocol
{
    func register(email : String, password : String)
}

protocol PresenterToRouterRegisterProtocol
{
    static func createModule(ref: RegisterViewController)
}
