//
//  CartSizeCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 12/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol CartSizeCollectionViewCellDelegate: class {
    func cartSizeCollectionViewCell(touchUpInsideAt cell: CartSizeCollectionViewCell, view: UICollectionView)
}

class CartSizeCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CartSizeCollectionViewCellDelegate?
    var collectionView: UICollectionView!
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var label: Label!
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        delegate?.cartSizeCollectionViewCell(touchUpInsideAt: self, view: collectionView)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.borderColor = UIColor(rgb: 0x707070).cgColor
        view.layer.borderWidth = 1
    }
}
