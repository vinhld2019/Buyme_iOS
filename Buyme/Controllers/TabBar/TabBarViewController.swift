//
//  TabBarViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class TabBarViewController: BaseViewController {
    
    @IBOutlet weak var tabBarView: UIView!
    
    @IBAction func tabBarItemSelected(_ sender: UIButton) {
        let tag = sender.tag
        if let key = TabBarItemKey(rawValue: tag) {
            self.moveItem(for: key)
        }
    }
    
    private func moveItem(for key: TabBarItemKey) {
        if key == .cart {
            navigationController?.pushViewController(key.viewController.init(), animated: true)
            return
        }
        
        if key.rawValue == currentIndex {
            return
        }
        
        if let vc = home {
            if currentIndex == TabBarItemKey.home.rawValue {
                vc.currentCell?.pause()
            }
            if key == .home {
                vc.playCurrentCell()
            }
        }
        
        currentIndex = key.rawValue
        var added: Bool = false
        for view in views {
            if view.tag == key.rawValue {
                view.isHidden = false
                added = true
            } else {
                view.isHidden = true
            }
        }
        
        if !added {
            addTabBarItem(viewController: key.viewController.init())
        }
    }
    
    private func addTabBarItem(viewController: UIViewController) {
        addChild(viewController)
        viewController.didMove(toParent: self)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        view.sendSubviewToBack(viewController.view)
        views.append(viewController.view)
    }
    
    var home: HomeViewController? { self.getChild(class: HomeViewController.self) }
    var discover: DiscoverViewController? { self.getChild(class: DiscoverViewController.self) }
    var cart: CartViewController? { self.getChild(class: CartViewController.self) }
    var personal: PersonalViewController? { self.getChild(class: PersonalViewController.self) }
    
    private func getChild<T: BaseViewController>(class: T.Type) -> T? {
        for vc in children where vc is T {
            return vc as? T
        }
        return nil
    }
    
    private var views: [UIView] = []
    var currentIndex: Int = -1
    var isTabBarEnable: Bool! {
        get { !tabBarView.isHidden }
        set {
            tabBarView.isHidden = !newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        moveItem(for: .home)
    }
    
    enum TabBarItemKey: Int {
        case home       = 0
        case discover   = 1
        case cart       = 2
        case personal   = 3
        
        var information: (UIViewController.Type) {
            switch self {
            case .home:
                return HomeViewController.self
                
            case .discover:
                return DiscoverViewController.self
                
            case .cart:
                return CartViewController.self
                
            case .personal:
                return PersonalViewController.self
            }
        }
        
        var viewController: UIViewController.Type { information }
    }

}
