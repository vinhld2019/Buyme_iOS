//
//  AppUtil.swift
//  Buyme
//
//  Created by Vinh LD on 2/7/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
protocol Copyable: class {
    init(copy: Self)
}
class AppUtils: NSObject {

    static let shared: AppUtils = AppUtils()

    var topAnchorHeight: CGFloat = 0
    var isLoggingOut = true

    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    var sceneDelegate: SceneDelegate? {
        return SceneDelegate.shared
    }

    var window: UIWindow? { WindowUtils.shared.window }

    var navigationController: NavigationController? {
        return window?.rootViewController as? NavigationController
    }

    func pushViewController(typeClass: UIViewController.Type, animated: Bool = true) {
        navigationController?.pushViewController(typeClass.init(), animated: animated)
    }

    func present(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overFullScreen
        navigationController?.present(viewController, animated: flag, completion: completion)
    }
    
    func showAlert(tag: Int = 0, type: AlertViewType = .alert, title: String? = "Mobile Banking", content: String? = nil, contentView: UIView? = nil, okButton: String? = "Close", cancel: String? = "Cancel", delegate: AlertViewDelegate? = nil) {
        window?.showAlert(tag: tag, type: type, title: title, content: content, contentView: contentView, okButton: okButton, cancel: cancel, delegate: delegate)
    }

    func logout() {
        if !isLoggingOut {
            self.isLoggingOut = true
            //logout handle
        }
    }
}
