//
//  Config.swift
//  Buyme
//
//  Created by Vinh LD on 7/23/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

class Config: NSObject {
    static let shared = Config()
    
    let apiURL: String = ApiURL.dev.rawValue
    let defaultKey: String = "VinhLD@2020"
    let googleMapsKey: String = ""
}

enum ApiURL: String {
    case dev
    case uat
    case production
}
