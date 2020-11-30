//
//  Category.swift
//  Buyme
//
//  Created by Vinh LD on 11/30/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

class Category {
    
    var name: String?
    var image: String?
    var parrent: Category?
    var children: [Category] = []
    
    init( name: String, parrent: Category? = nil, children: [Category] = []) {
        self.parrent = parrent
        self.name = name
        self.children = children
    }
}
