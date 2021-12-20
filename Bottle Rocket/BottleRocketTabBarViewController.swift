//
//  BottleRocketTabBarControllerViewController.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 12/14/21.
//

import UIKit

class BottleRocketTabBarViewController: UITabBarController,UITabBarControllerDelegate {
    private let internetViewController = InternetViewController ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let barItem1 = UITabBarItem(title: "Internets", image: UIImage(systemName: "house"), tag: 1)
        internetViewController.tabBarItem = barItem1
        self.viewControllers?.append(internetViewController)
    }
    
}
 
