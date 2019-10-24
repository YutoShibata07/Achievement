//
//  TabbarController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit


protocol TabbarDelegate {
    func didSelectTab(tabbarController:UITabBarController)
}

class AchieveTabbarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
   
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("hhhhh")
    }
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is TabbarDelegate{
            let graphView = viewController as? TabbarDelegate
            graphView?.didSelectTab(tabbarController: self)
        }
    }

}
