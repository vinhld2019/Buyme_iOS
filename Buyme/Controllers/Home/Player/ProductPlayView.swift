//
//  ProductPlayView.swift
//  Buyme
//
//  Created by Vinh LD on 11/30/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import BMPlayer
import SnapKit

class ProductPlayView: FromNibBaseView {
    
    @IBOutlet weak var player: BMPlayer!
    @IBOutlet weak var categoryLabel: Label!
    @IBOutlet weak var authorLabel: Label!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var heartLabel: Label!
    @IBOutlet weak var commentsLabel: Label!
    @IBOutlet weak var shareLabel: Label!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var priceLabel: Label!
    @IBOutlet weak var soldLabel: Label!
    @IBOutlet weak var descriptionLabel: Label!
    
    @IBAction func touchUpInside(_ sender: UIButton) {
        player.isPlaying ? player.pause() : player.play()
    }
    
    @IBAction func categoryTouchUpInside(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            AppUtils.shared.pushViewController(typeClass: SearchWithCategoriesViewController.self)
            
        default:
            AppUtils.shared.pushViewController(typeClass: SearchWithCategoriesViewController.self)
        }
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case kShareTag:
            let vc = UIActivityViewController(activityItems: ["https://www.facebook.com/vnvinhld"], applicationActivities: nil)
            AppUtils.shared.present(vc, animated: true)
            
        case kCommentTag:
            break
            
        case kHeartTag:
            break
            
        case kCartTag:
            self.superSuperview.addToCartShow()
            
        default:
            break
        }
    }
    
    let kShareTag: Int = 0
    let kCommentTag: Int = 1
    let kHeartTag: Int = 2
    let kCartTag: Int = 3
    
    var name: String? {
        get { nameLabel.text }
        set { nameLabel.text = newValue }
    }
    
    var detail: String? {
        get { descriptionLabel.text }
        set { descriptionLabel.text = newValue }
    }
    
    func setVideo(link: String?) {
        if let link = link, let path = Bundle.main.path(forResource: link, ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            DispatchQueue.main.async {
                self.player.setVideo(resource: .init(url: url))
                self.player.pause()
            }
        }
//        if let link = link, let url = URL(string: link) {
//            DispatchQueue.main.async {
//                self.player.setVideo(resource: .init(url: url))
//                self.player.pause()
//            }
//        }
    }
    
    func play() {
        DispatchQueue.main.async {
            self.player.play()
        }
    }
    
    func pause() {
        DispatchQueue.main.async {
            self.player.pause()
        }
    }
}
