//
//  LoginProtocol.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import Foundation

protocol ViewToPresenterLoginProtocol
{
    var loginInteractor : PresenterToInteractorLoginProtocol? {get set}
    func loginUser(email : String, password : String )
}

protocol PresenterToInteractorLoginProtocol
{
    func login(email : String, password : String )
}

protocol PresenterToRouter
{
    static func createModule(ref:LoginViewController)
}

// loginAll - loginUser
