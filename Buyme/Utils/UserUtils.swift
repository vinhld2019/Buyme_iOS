//
//  UserUtils.swift
//  Buyme
//
//  Created by Vinh LD on 3/31/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class UserUtils: NSObject {

    static var shared = UserUtils()

    var username: String? {
        get {
            UserDefaultsUtils.shared.username
        }
        set {
            UserDefaultsUtils.shared.username = newValue
        }
    }
    var password: String? {
        get {
            KeychainUtils.shared.password
        }
        set {
            KeychainUtils.shared.password = newValue
        }
    }
    
    func invalidate() {
        Self.shared = UserUtils()
    }
}
