//
//  RegisterViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 5.04.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    
    var registerPresneterObject : ViewToPresenterRegisterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiDesign()
        RegisterRouter.createModule(ref: self)
    }
    
    func uiDesign(){
        registerView.layer.cornerRadius = 40
        registerBtn.layer.cornerRadius = 10
        registerBtn.layer.borderWidth = 1
        self.navigationItem.hidesBackButton = true
    }
    @IBAction func backClicked(_ sender: Any) {
       // performSegue(withIdentifier: "toWelcome", sender: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        if let te = emailTF.text, let tp = passwordTF.text{
            registerPresneterObject?.registerUser(email: te, password: tp)
        }
        
        let alert = UIAlertController(title: "Register", message: "Register is successful.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        {
            action in
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        alert.addAction(okayAction)
        self.present(alert, animated: true)
       
    }

}
