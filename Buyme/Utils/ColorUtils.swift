//
//  ColorUtils.swift
//  Buyme
//
//  Created by Vinh LD on 2/14/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class ColorUtils: NSObject {
    static let shared = ColorUtils()

    let appColor: UIColor = UIColor(rgb: 0xFBBC05)
    let gray1: UIColor = UIColor(rgb: 0x707070)
    let gray2: UIColor = UIColor(rgb: 0xDDDDDD)
    let gray3: UIColor = UIColor(rgb: 0xEEEEEE)
    
    let red: UIColor = UIColor(rgb: 0xAE1C3F)
    var gray: UIColor = .gray
    var green: UIColor = .green
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat? = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha! >= 0 && alpha! <= 1, "Invalid alpha component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha! / 1.0)
    }

    convenience init(rgb: Int, alpha: CGFloat? = 1.0) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha!)
    }

}
