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
//            self.addChild()
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
    
    @objc func panDirection(_ pan: UIPanGestureRecognizer) {
        let locationPoint = pan.location(in: self.view)
        let x = shopViewController.view.frame.origin.x
        let width = shopViewController.view.frame.size.width
        
        switch pan.state {
        case .began:
            startX = locationPoint.x
            
        case .changed:
            let xChanged = locationPoint.x - startX
            var newX = x + xChanged
            if newX < 0 { newX = 0 }
            if newX > width { newX = width }
            shopViewController.view.frame.origin.x = newX
            
        case .cancelled:
            childHandler()
            
        case .failed:
            childHandler()
            
        case .ended:
            if (childShowing && x > -width / 2)
                || (!childShowing && x < 0) {
                childShowing = !childShowing
                childHandler()
            }
            
        default:
            break
        }
    }
    
    private func childHandler() {
        if childShowing {
//            currentCell?.pause()
        } else {
//            playCurrentCell()
        }
        let x = childShowing ? 0 : -self.shopViewController.view.frame.size.width
        UIView.animate(withDuration: 0.3, animations: {
            self.shopViewController.view.frame.origin.x = x
        }, completion: { _ in
            self.shopViewController.view.frame.origin.x = x
        })
    }
    
    func viewShop() {
        childShowing = true
        childHandler()
    }
    
    var childShowing: Bool = false
    var startX: CGFloat = 0
    var panDirection: Int = 0
    var shopViewController: ShopViewController = .init()
    
    private func addChild() {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        
        addChild(shopViewController)
        shopViewController.didMove(toParent: self)
        view.addSubview(shopViewController.view)
        shopViewController.view.frame = CGRect(x: width, y: 0, width: width, height: height)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panDirection(_:)))
        shopViewController.view.addGestureRecognizer(pan)
        shopViewController.view.isUserInteractionEnabled = true
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

class UIGestureRecognizerDelegateDefault: NSObject, UIGestureRecognizerDelegate {
    
    static let shared = UIGestureRecognizerDelegateDefault()
    
    // called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
    // @available(iOS 3.2, *)
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    
    // called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
    // return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
    //
    // note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
    // @available(iOS 3.2, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    
    // called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
    // return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
    //
    // note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES
    // @available(iOS 7.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    // @available(iOS 7.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    
    // called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
    // @available(iOS 3.2, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        false
    }
    
    
    // called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
    @available(iOS 9.0, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        false
    }
    
    
    // called once before either -gestureRecognizer:shouldReceiveTouch: or -gestureRecognizer:shouldReceivePress:
    // return NO to prevent the gesture recognizer from seeing this event
    @available(iOS 13.4, *)
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        false
    }
}
