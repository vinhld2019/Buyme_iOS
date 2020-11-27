//
//  ClassName.swift
//  Me Click
//
//  Created by Vinh LD on 7/23/19.
//  Copyright © 2019 VinhLD. All rights reserved.
//

import UIKit

protocol ClassNameable {
    static var className: String { get }
}

extension ClassNameable {
    static var className: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: Self.className, bundle: nil)
    }
}

extension NSObject: ClassNameable {}
