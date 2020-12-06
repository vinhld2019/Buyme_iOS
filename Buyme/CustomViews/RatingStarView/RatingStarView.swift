//
//  RatingStarView.swift
//  Buyme
//
//  Created by Vinh LD on 12/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class RatingStarView: FromNibBaseView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingConstrain: NSLayoutConstraint!
    
    @IBInspectable var value: CGFloat = 2.5
    
    override func initViews() {
        super.initViews()
        
        imageView.image = UIImage(named: "RatingStar")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = ColorUtils.shared.appColor
        
        self.refreshValue()
    }
    
    private func refreshValue() {
        DispatchQueue.main.async {
            let width = self.view.bounds.size.width
            let leading = width * self.value / 5
            self.ratingConstrain.constant = leading
        }
    }
}
