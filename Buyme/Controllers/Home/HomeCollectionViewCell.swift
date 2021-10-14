//
//  HomeCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 12/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import BMPlayer

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var player: BMPlayer!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var shareButton: PlayerButton!
    @IBOutlet weak var commentButton: PlayerButton!
    @IBOutlet weak var likeButton: PlayerButton!
    @IBOutlet weak var cartButton: PlayerButton!
    
    @IBOutlet weak var rightActionView: UIView!
    @IBOutlet weak var bottomActionView: UIView!
    
    @IBAction func viewSeller(_ sender: UIButton) {
        let vc = SellerViewController()
        navigation?.pushViewController(vc, animated: true)
    }
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        if player.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    var link: String? {
        didSet {
            if let link = link, let path = Bundle.main.path(forResource: link, ofType: "mp4") {
                let url = URL(fileURLWithPath: path)
                DispatchQueue.main.async {
                    self.player.setVideo(resource: .init(url: url))
                    self.player.pause()
                }
            }
        }
    }
    
    func play() {
        playImageView.isHidden = true
        player.play()
    }
    
    func pause() {
        playImageView.isHidden = false
        player.pause()
    }
    
    func updateDisplayActions() {
        rightActionView.isHidden = playerActionIsHidden
        bottomActionView.isHidden = playerActionIsHidden
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shareButton.delegate = self
        commentButton.delegate = self
        likeButton.delegate = self
        cartButton.delegate = self
    }

}

extension HomeCollectionViewCell: PlayerButtonDelegate {
    func playerButton(touchAt button: PlayerButton) {
        let tag = button.tag
        switch tag {
        case 0:
            let vc = UIActivityViewController(activityItems: ["https://www.facebook.com/vnvinhld"], applicationActivities: nil)
            AppUtils.shared.present(vc, animated: true)
            
        case 1:
            let vc = CommentViewController()
            vc.modalPresentationStyle = .overFullScreen
            navigation?.present(vc, animated: true, completion: nil)
            
        case 2:
            let isSelected = !button.isSelected
            button.isSelected = isSelected
            button.imageView.tintColor = isSelected ? ColorUtils.shared.red : .white
            
        case 3:
            AppUtils.shared.present(AddCartViewController(), animated: true)
            
        default:
            break
        }
    }
}
