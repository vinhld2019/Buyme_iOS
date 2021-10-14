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
        setViewControllers([StartShoppingViewController()], animated: false)
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
