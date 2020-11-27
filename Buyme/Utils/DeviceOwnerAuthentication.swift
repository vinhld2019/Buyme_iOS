//
//  DeviceOwnerAuthentication.swift
//  Buyme
//
//  Created by Vinh LD on 2/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import LocalAuthentication

let kPasscodeNotSet         = Int(kLAErrorPasscodeNotSet)
let kBiometryNotAvailable   = Int(kLAErrorBiometryNotAvailable)
let kBiometryNotEnrolled    = Int(kLAErrorBiometryNotEnrolled)
let kBiometryLockout        = Int(kLAErrorBiometryLockout)
let kAuthenticationFailed   = Int(kLAErrorAuthenticationFailed)
let kUserCancel             = Int(kLAErrorUserCancel)
let kUserFallback           = Int(kLAErrorUserFallback)
let kSystemCancel           = Int(kLAErrorSystemCancel)
let kAppCancel              = Int(kLAErrorAppCancel)

class DeviceOwnerAuthentication {

    static var shared: DeviceOwnerAuthentication {
        return DeviceOwnerAuthentication()
    }

    init() {
        self.initialization()
    }

    func initialization() {
        var error: NSError?
        let context = LAContext()
        self.canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if canEvaluatePolicy {
            self.biometricSupported = true
            self.biometricEnable = true
        } else {
            guard let code = error?.code else {
                return
            }

            self.code = code

            switch code {
            case kBiometryNotEnrolled:
                biometricSupported  = true
                biometricEnable     = false
            case kBiometryLockout:
                biometricSupported  = true
                biometricEnable     = true
            default:
                biometricSupported  = false
                biometricEnable     = false
            }
        }
    }

    var canEvaluatePolicy: Bool = false
    var biometricSupported: Bool = false
    var biometricEnable: Bool = false
    var code: Int = -1

    var biometricLockout: Bool {
        return code == kBiometryLockout
    }

    func showDeviceOwnerAuthentication(completionHandler: @escaping (Bool, Int?) -> Void) {
        if canEvaluatePolicy {
            let context = LAContext()
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use your TouchID") { (success, error) in
                if let code = (error as NSError?)?.code {
                    self.code = code
                }
                completionHandler(success, self.code)
            }
        } else {
            completionHandler(false, self.code)
        }
    }
}
