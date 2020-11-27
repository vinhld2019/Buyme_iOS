//
//  NothingHandleutils.swift
//  Buyme
//
//  Created by Vinh LD on 9/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import ObjectMapper

func nothingHandle(map: Map? = nil,
                   text: String? = nil,
                   error: Error? = nil,
                   number: Int64? = nil,
                   view: UIView? = nil) {
    NothingHandleutils.shared.map = map
    NothingHandleutils.shared.text = text
    NothingHandleutils.shared.error = error
    NothingHandleutils.shared.number = number
}

class NothingHandleutils: NSObject {
    static let shared = NothingHandleutils()
    
    var text: String?
    var map: Map?
    var error: Error?
    var number: Int64?
}
