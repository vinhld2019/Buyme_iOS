//
//  LocalizedUtils.swift
//  Buyme
//
//  Created by Vinh LD on 2/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import DPLocalization

class LocalizedUtils: NSObject {

    static let shared = LocalizedUtils()

    var languagesCode: [String] {
        ["vi",
         "en"]
    }
    var languageDefault: String { "vi" }

    func initialization() {
        if let current = Locale.current.languageCode {
            self.current = languagesCode.contains(current) ? current : self.languageDefault
        }
    }

    var current: String? {
        get {
            return dp_get_current_language()
        }
        set {
            dp_set_current_language(newValue)
        }
    }
}

public extension String {

    var localize: String {
        return getString(with: nil) ?? self
    }
    
    func getString(with language: String?) -> String? {
        let id = language ?? LocalizedUtils.shared.current
        if let path = Bundle.main.path(forResource: id, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        }
        return nil
    }
}
