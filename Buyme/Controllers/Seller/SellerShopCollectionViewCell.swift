//
//  SellerShopCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 1/3/21.
//  Copyright © 2021 Vinh LD. All rights reserved.
//

import UIKit

class SellerShopCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tag = idTag % 18
        idTag += 1
        let id = tag < 10 ? "0\(tag)" : "\(tag)"
        imageView.image = UIImage(named: "ID\(id)")
    }

}
