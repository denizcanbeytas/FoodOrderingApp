//
//  LoginViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 2.04.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var loginPresenterObject : ViewToPresenterLoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDesign()
        
        LoginRouter.createModule(ref: self)
        
    }
    
    func uiDesign(){
        loginView.layer.cornerRadius = 40
        loginBtnView.layer.cornerRadius = 10
        loginBtnView.layer.borderWidth = 1
        self.navigationItem.hidesBackButton = true
     
    }
    @IBAction func backClicked(_ sender: Any) {
        //performSegue(withIdentifier: "toWelcome", sender: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        //deneme.isHidden = true
        if emailTF.text != "" && passwordTF.text != "" {
            let auth = Auth.auth()
            auth.signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (authdata, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(OKAction)
                    self.present(alert, animated: true)

                } else {
                    //self.navigationController?.popToRootViewController(animated: true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarControllerId") as! UITabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }

            }
        } else {
            let alert = UIAlertController(title: "Error", message:"username/password ?", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(OKAction)
            self.present(alert, animated: true)
        }
    }
}
