//
//  UserDefaultsUtils.swift
//
//  Created by Vinh LD on 1/23/19.
//  Copyright © 2019 Vinh LD. All rights reserved.
//

import Foundation

class UserDefaultsUtils: NSObject {
    static var shared = UserDefaultsUtils()

    let standard = UserDefaults.standard

    func remove(key: String) {
        standard.removeObject(forKey: key)
    }

    func set(key: String, value: Any?) {
        standard.set(value, forKey: key)
    }

    func getString(key: String) -> String? {
        return standard.string(forKey: key)
    }

    func getInt(key: String) -> Int {
        return standard.integer(forKey: key)
    }

    func getBool(key: String) -> Bool {
        return standard.bool(forKey: key)
    }

    func getCGFloat(key: String) -> Double {
        return standard.double(forKey: key)
    }

    func getArray(key: String) -> [Any]? {
        return standard.array(forKey: key)
    }

    func get(key: String) -> Any? {
        return standard.value(forKey: key)
    }

    /* MARK: Login Type
     * 1: Biometric
     * Default: Manual
     */
    var loginByFingerprint: Bool {
        get {
            return getInt(key: kLoginType) == 1
        }
        set {
            set(key: kLoginType, value: newValue ? 1 : 0)
        }
    }

    var username: String? {
        get {
            return getString(key: kUsername)
        }
        set {
            set(key: kUsername, value: newValue)
        }
    }

    var greaterThanTimeOpen: Bool {
        get {
            return getBool(key: kFirstOpen)
        }
        set {
            set(key: kFirstOpen, value: newValue)
        }
    }
}
