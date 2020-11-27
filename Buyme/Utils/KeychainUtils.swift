//
//  KeychainUtils.swift
//  Buyme
//
//  Created by Vinh LD on 2/27/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainUtils: NSObject {

    static var shared = KeychainUtils()
    
    private var keychain: Keychain {
        var service: String = defaultKey
        if let userInfo = Bundle.main.infoDictionary,
            let key = kCFBundleNameKey as String?,
        let name = userInfo[key] as? String {
            service += "_\(name)"
        }
        return Keychain(service: service)
    }
    
    private let defaultKey: String = Config.shared.defaultKey
    private var passwordKey: String { "\(defaultKey)_Password" }

    var password: String? {
        get {
            return self.keychain[self.passwordKey]
        }
        set {
            if let value = newValue {
                self.keychain[self.passwordKey] = value
            }
        }
    }
}
