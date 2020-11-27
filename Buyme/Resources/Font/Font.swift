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
        black = UIFont(name: kRobotoBlack, size: 13)
        blackItalic = UIFont(name: kRobotoBlackItalic, size: 13)
        bold = UIFont(name: kRobotoBold, size: 13)
        boldItalic = UIFont(name: kRobotoBoldItalic, size: 13)
        italic = UIFont(name: kRobotoItalic, size: 13)
        light = UIFont(name: kRobotoLight, size: 13)
        lightItalic = UIFont(name: kRobotoLightItalic, size: 13)
        medium = UIFont(name: kRobotoMedium, size: 13)
        mediumItalic = UIFont(name: kRobotoMediumItalic, size: 13)
        regular = UIFont(name: kRobotoRegular, size: 13)
        thin = UIFont(name: kRobotoThin, size: 13)
        thinItalic = UIFont(name: kRobotoThinItalic, size: 13)
    }
    
    var black: UIFont?
    var blackItalic: UIFont?
    var bold: UIFont?
    var boldItalic: UIFont?
    var italic: UIFont?
    var light: UIFont?
    var lightItalic: UIFont?
    var medium: UIFont?
    var mediumItalic: UIFont?
    var regular: UIFont?
    var thin: UIFont?
    var thinItalic: UIFont?

    private let kRobotoBlack: String        = "Roboto-Black"
    private let kRobotoBlackItalic: String  = "Roboto-BlackItalic"
    private let kRobotoBold: String         = "Roboto-Bold"
    private let kRobotoBoldItalic: String   = "Roboto-BoldItalic"
    private let kRobotoItalic: String       = "Roboto-Italic"
    private let kRobotoLight: String        = "Roboto-Light"
    private let kRobotoLightItalic: String  = "Roboto-LightItalic"
    private let kRobotoMedium: String       = "Roboto-Medium"
    private let kRobotoMediumItalic: String = "Roboto-MediumItalic"
    private let kRobotoRegular: String      = "Roboto-Regular"
    private let kRobotoThin: String         = "Roboto-Thin"
    private let kRobotoThinItalic: String   = "Roboto-ThinItalic"
}
