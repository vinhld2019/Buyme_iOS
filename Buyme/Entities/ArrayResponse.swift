//
//  ArrayResponse.swift
//  Buyme
//
//  Created by Vinh LD on 9/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import ObjectMapper

class ArrayResponse<D: Mappable>: BaseResponse {
    var list: [D] = []
    
    override func mapping(map: Map) {
        list <- map["list"]
    }
}
