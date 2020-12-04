//
//  AddToCartView.swift
//  Buyme
//
//  Created by Vinh LD on 12/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class AddToCartView: FromNibBaseView {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var phanloaiCollectionView: UICollectionView!
    @IBOutlet weak var mauCollectionView: UICollectionView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    @IBAction func close(_ sender: UIButton) {
        sender.backgroundColor = .clear
        Self.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = self.frame.size.height
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}

extension UIView {
    func addToCartShow() {
        let view = AddToCartView()
        addSubview(view)
        
        var frame = self.bounds
        frame.origin.y = self.bounds.size.height
        view.frame = frame
        Self.animate(withDuration: 0.3, animations: {
            view.frame.origin.y = 0
        }, completion: { _ in
            view.frame.origin.y = 0
            view.closeButton.backgroundColor = .init(rgb: 0x000000, alpha: 0.4)
        })
    }
}
