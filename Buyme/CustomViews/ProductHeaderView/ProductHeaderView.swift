//
//  ProductHeaderView.swift
//  Buyme
//
//  Created by Vinh LD on 12/5/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol ProductHeaderViewDelegate: class {
    func productHeader(_ view: ProductHeaderView, action: ProductHeaderViewAction)
}

enum ProductHeaderViewAction {
    case left
    case right
}

class ProductHeaderView: FromNibBaseView {
    
    weak var delegate: ProductHeaderViewDelegate?
    
    @IBOutlet weak var label: Label!
    
    @IBAction func leftAction(_ sender: UIButton) {
        delegate?.productHeader(self, action: .left)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        delegate?.productHeader(self, action: .right)
    }
    
    var title: String? {
        get { label.text }
        set {
            DispatchQueue.main.async {
                self.label.autolocalizationKey = newValue
            }
        }
    }
}
