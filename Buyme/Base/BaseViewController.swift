//
//  BaseViewController.swift
//  Buyme
//
//  Created by Vinh LD on 2/14/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, AlertViewDelegate {
    
    @IBAction func back(_ sender: UIButton) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = navigationController?.viewControllers.count == 1 ? UIGestureRecognizerDelegateDefault.shared : nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func showLoading(tag: Int = 0) {
        view.superSuperview.showLoading(tag: tag)
    }

    func hideLoading(tag: Int = 0) {
        view.superSuperview.hideLoading(tag: tag)
    }

    func toast(_ text: String) {
        self.view.endEditing(true)
        self.view.toast(message: text)
    }

    func alert(message: String) {
        view.endEditing(true)
        AppUtils.shared.showAlert(tag: TagUtils.shared.newTag, title: title ?? "Mobile Banking", content: message, delegate: self)
    }
    
    // AlertViewDelegate
    func alertViewClose(_ view: AlertView) {
        nothingHandle()
    }
    func alertViewOk(_ view: AlertView) {
        nothingHandle()
    }
}

protocol BaseViewControllerCallback: AnyObject {
    func responses(_ viewController: BaseViewController)
}
