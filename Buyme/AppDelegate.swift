//
//  AppDelegate.swift
//  Buyme
//
//  Created by Vinh LD on 2/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import IQKeyboardManager
import DPLocalization
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? {
        get { WindowUtils.shared.window }
        set { WindowUtils.shared.window = newValue }
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        WindowUtils.shared.makeKeyAndVisible()
        
        ApiUtils.shared.initialization()
        
        IQKeyboardManager.shared().isEnabled = true
        
        if !UserDefaultsUtils.shared.greaterThanTimeOpen {
            UserDefaultsUtils.shared.greaterThanTimeOpen = true
            LocalizedUtils.shared.initialization()
        }

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        WindowUtils.shared.checkJailbroken()
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
