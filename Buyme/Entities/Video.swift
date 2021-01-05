//
//  Video.swift
//  Buyme
//
//  Created by Vinh LD on 12/28/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

class Video {
    
    var isSelected: Bool = false
    var link: String?
    var image: String?
    var text: String?
    
    init(link: String?, image: String?, text: String?) {
        self.link = link
        self.image = image
        self.text = text
    }
}
