//
//  LogUtils.swift
//  Buyme
//
//  Created by Vinh LD on 9/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

class Mics: NSObject {
    
    static let shared: Mics = Mics()
    
    func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        print(items, separator: separator, terminator: terminator)
    }
}
