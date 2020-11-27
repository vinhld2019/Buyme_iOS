//
//  ViewController.swift
//  Buyme
//
//  Created by Vinh LD on 2/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import DPLocalization

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
        DispatchQueue.main.async {
            let frame = self.view.safeAreaLayoutGuide.layoutFrame
            AppUtils.shared.topAnchorHeight = frame.origin.y
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isNavigationBarHidden = true
        interactivePopGestureRecognizer?.delegate = nil
    }

    func initialization() {
        setViewControllers([TabBarViewController()], animated: false)
    }
}

extension UINavigationController {
    func popLast(popCount: Int = 1, push viewController: UIViewController? = nil) {
        var viewControllers = self.viewControllers
        for _ in 1...popCount where viewControllers.count > 0 {
            viewControllers.removeLast()
        }
        if let vc = viewController {
            viewControllers.append(vc)
        }
        self.setViewControllers(viewControllers, animated: true)
    }
}
