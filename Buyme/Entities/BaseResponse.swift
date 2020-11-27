//
//  BaseResponse.swift
//  Buyme
//
//  Created by Vinh LD on 9/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    required init?(map: Map) {
        nothingHandle(map: map)
    }
    
    func mapping(map: Map) {
    }
}
