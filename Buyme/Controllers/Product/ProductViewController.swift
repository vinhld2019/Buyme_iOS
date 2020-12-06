//
//  ProductViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/4/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class ProductViewController: BaseViewController {
    
    @IBOutlet weak var header: ProductHeaderView!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        header.delegate = self
        header.title = "Tên sản phẩm"
    }

}

extension ProductViewController: ProductHeaderViewDelegate {
    func productHeader(_ view: ProductHeaderView, action: ProductHeaderViewAction) {
        switch action {
        case .left:
            navigationController?.popViewController(animated: true)
            
        case .right:
            print("Right")
        }
    }
}
