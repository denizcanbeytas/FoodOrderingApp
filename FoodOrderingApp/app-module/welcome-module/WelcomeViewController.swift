//
//  WelcomeViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 5.04.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var loginBtnView: UIView!
    @IBOutlet weak var createBtnView: UIView!
    @IBOutlet weak var welcomeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiDesign()
    }
    
    func uiDesign(){
        welcomeView.layer.cornerRadius = 40
        createBtnView.layer.cornerRadius = 10
        createBtnView.layer.borderWidth = 1
        loginBtnView.layer.cornerRadius = 10
        loginBtnView.layer.borderWidth = 1
    }
    @IBAction func loginBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
}

extension UIView
{
//    func addBlurEffect()
//    {
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.addSubview(blurEffectView)
//    }
}
