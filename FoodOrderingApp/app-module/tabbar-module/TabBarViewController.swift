//
//  TabBarViewController.swift
//  FoodOrderingApp
//
//  Created by Deniz on 3.04.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ChangeRadiusOfTabbar()
        //self.changeUnSelectedColor()
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.SimpleAnnimationWhenSelectItem(item)
    }
    
    override func viewDidLayoutSubviews() {
       self.ChangeHeightOfTabbar()
    }
    
    func ChangeRadiusOfTabbar(){
        
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
//        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
//        self.tabBar.layer.shadowRadius = 4.0
//        self.tabBar.layer.shadowColor = UIColor.gray.cgColor
//        self.tabBar.layer.shadowOpacity = 0.6
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
           }
    func changeUnSelectedColor(){
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    
    func ChangeHeightOfTabbar(){
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame            = tabBar.frame
            tabFrame.size.height    = 100
            tabFrame.origin.y       = view.frame.size.height - 100
            tabBar.frame            = tabFrame
        }
    
    }
    
    // Jump Effect
    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.4
        
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
        barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
            
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    


}

