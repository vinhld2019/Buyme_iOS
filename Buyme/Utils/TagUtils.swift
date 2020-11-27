//
//  TagUtils.swift
//  Buyme
//
//  Created by Vinh LD on 4/28/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

class TagUtils {
    static let shared = TagUtils()
    
    var tag: Int = 2020
    
    var newTag: Int {
        self.tag += 1
        return self.tag
    }
}
