//
//  FollowingView.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import BMPlayer

class FollowingView: BaseView {
    
    var player: VideoPlayerView!
    var link: String? {
        get { player.link }
        set {
            DispatchQueue.main.async {
                self.player.link = newValue
            }
        }
    }
    
    override func initViews() {
        player = .init()
        addSubview(player)
        player.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
}
