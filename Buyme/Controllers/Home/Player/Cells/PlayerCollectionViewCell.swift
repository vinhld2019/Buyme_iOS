//
//  PlayerCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 12/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playView: ProductPlayView!

    var product: Product? {
        didSet {
            playView.setVideo(link: product?.video)
        }
    }
    
    func play() {
        playView.play()
    }
    
    func pause() {
        playView.pause()
    }

}
