//
//  HomeViewController+PostButtonViewDelegate.swift
//  Buyme
//
//  Created by Vinh LD on 11/27/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

extension HomeViewController: PostButtonViewDelegate {
    func postButtonView(touchUpInsideAt view: PostButtonView) {
        let tag = view.tag
        switch tag {
        case 2:
            view.image = view.image?.withRenderingMode(.alwaysTemplate)
            view.imageView.tintColor = .red
            
        default:
            break
        }
    }
}
