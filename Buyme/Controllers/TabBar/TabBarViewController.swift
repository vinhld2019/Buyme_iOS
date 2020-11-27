//
//  TabBarViewController.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let titles: [String] = ["Home", "Search", "Create New", "User"]
    private let itemsImage: [String] = ["TBIHome", "TBISearch", "", ""]
    private let selectedItemsImage: [String] = ["TBISelectedHome", "TBISelectedSearch", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = ColorUtils.shared.appColor
        tabBar.unselectedItemTintColor = ColorUtils.shared.gray1
//        tabBar.barTintColor = UIColor.white

        let vcs = [HomeViewController(), SearchViewController(), CreateNewViewController(), UserManagerViewController()]
        for index in 0...vcs.count - 1 {
            vcs[index].tabBarItem
                = .init(title: self.titles[index],
                        image: UIImage(named: itemsImage[index])?.withRenderingMode(.alwaysOriginal),
                        selectedImage: UIImage(named: selectedItemsImage[index])?.withRenderingMode(.alwaysOriginal))
        }
        self.viewControllers = vcs
    }

}
