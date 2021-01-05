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
    
    static func register(_ view: UICollectionView) {
        view.register(nib, forCellWithReuseIdentifier: className)
    }
    
    static func cell(for view: UICollectionView, at indextPath: IndexPath) -> Self? {
        view.dequeueReusableCell(withReuseIdentifier: className, for: indextPath) as? Self
    }
    
    static func register(_ view: UITableView) {
        view.register(nib, forCellReuseIdentifier: className)
    }
    
    static func cell(for view: UITableView, at indexPath: IndexPath) -> Self? {
        view.dequeueReusableCell(withIdentifier: className, for: indexPath) as? Self
    }
    
    var navigation: NavigationController? {
        AppUtils.shared.navigationController
    }
}

extension NSObject: ClassNameable {}
