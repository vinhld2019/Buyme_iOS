//
//  Product.swift
//  Buyme
//
//  Created by Vinh LD on 11/30/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

class Product {
    var name: String?
    var image: String?
    var video: String?
    var description: String?
    var cost: Double?
    
    init(name: String?, video: String?, description: String?, cost: Double?) {
        self.name = name
        self.video = video
        self.description = description
        self.cost = cost
    }
}
