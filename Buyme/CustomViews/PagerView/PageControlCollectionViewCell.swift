//
//  PageControlCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 12/29/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class PageControlCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(isSelected: Bool) {
        imageView.image = UIImage(named: isSelected ? "PageControlSelected" : "PageControl")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
