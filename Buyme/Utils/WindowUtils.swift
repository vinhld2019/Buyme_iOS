//
//  WindowUtils.swift
//  Buyme
//
//  Created by Vinh LD on 9/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import UIKit

class WindowUtils: NSObject {
    
    static let shared = WindowUtils()

    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func makeKeyAndVisible(scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            
            // handle
            self.initialization()
        }
    }
    
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "Use makeKeyAndVisible with UIScene.")
    func makeKeyAndVisible() {
        if DeviceUtils.shared.deviceOS >= 13 {
            return
        }
        
        window = UIWindow()
        
        // handle
        self.initialization()
    }
    
    private func initialization() {
        window?.rootViewController = NavigationController()
        window?.makeKeyAndVisible()
    }
    
    func checkJailbroken() {
        guard TARGET_IPHONE_SIMULATOR != 1 else { return }
        
        if DeviceUtils.shared.isDeviceJailbroken {
            let alert = UIAlertController(title: "Not supported!", message: "Devices with 'Jaibreak' intervention are not supported.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .default) { _ in
                exit(0)
            }
            alert.addAction(action)
            window?.rootViewController?.present(alert, animated: false)
        }
    }
    
}
