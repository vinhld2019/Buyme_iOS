//
//  ShopForYouCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class ShopForYouCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view.layer.cornerRadius = 5
        view.layer.borderColor = ColorUtils.shared.gray3.cgColor
        view.layer.borderWidth = 1
    }

}
