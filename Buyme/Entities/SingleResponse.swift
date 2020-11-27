//
//  SingleResponse.swift
//  Buyme
//
//  Created by Vinh LD on 9/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import ObjectMapper

class SingleResponse<D: Mappable>: BaseResponse {
    var item: D?
    
    override func mapping(map: Map) {
        item <- map["item"]
    }
}
