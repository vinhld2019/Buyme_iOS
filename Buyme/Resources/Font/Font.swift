//
//  Font.swift
//  Buyme
//
//  Created by Vinh LD on 2/13/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class Font {

    static let shared = Font()

    init() {
        bold = UIFont(name: "SFProText-Bold", size: 13)
        medium = UIFont(name: "SFProText-Medium", size: 13)
        semibold = UIFont(name: "SFProText-Semibold", size: 13)
        regular = UIFont(name: "SFProText-Regular", size: 13)
        awesome = UIFont(name: kAwesome, size: 13)
    }
    
    var bold: UIFont?
    var medium: UIFont?
    var regular: UIFont?
    var semibold: UIFont?
    var awesome: UIFont?

    private let kAwesome: String            = "Font Awesome 5 Free"
}
