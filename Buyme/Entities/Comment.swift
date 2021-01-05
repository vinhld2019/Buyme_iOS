//
//  Comment.swift
//  Buyme
//
//  Created by Vinh LD on 12/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class Comment {
    var isLiked: Bool = false
    var isExpand: Bool = false
    var replies: [ReplyComment] = [.init(), .init()]
    var repliesHeight: CGFloat?
    
    init() {
        
    }
}

class ReplyComment {
    var isLiked: Bool = false
    
    init() {
        
    }
}
