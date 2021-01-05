//
//  ProductListCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 12/28/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progress: NSLayoutConstraint!
    
    var video: Video?
    
    func setup(video: Video?, percent: CGFloat = 0) {
        self.video = video
        if let named = video?.image, let image = UIImage(named: named) {
            imageView.image = image
        }
        label.text = video?.text
        
        progressView.isHidden = !(video?.isSelected ?? false)
        progress.constant = percent * 0.75
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
