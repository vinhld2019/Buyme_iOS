//
//  SearchWithCategoriesViewController.swift
//  Buyme
//
//  Created by Vinh LD on 11/30/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class SearchWithCategoriesViewController: BaseViewController {
    
    let kCategoriesTag: Int = 0
    let kProductsTag: Int = 0
    
    @IBOutlet weak var textField: TextField!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    override func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    var category: Category?
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
