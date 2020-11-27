//
//  VideoPlayerView.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import BMPlayer

class VideoPlayerView: BaseView {
    
    var player: BMPlayer!
    var link: String?
    
    override func initViews() {
        player = .init()
        self.addSubview(player)
        player.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        
        self.setVideo()
//        player.setVideo(resource: BMPlayerResource(url: URL(string: "")!, name: ""))
        
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
    }
    
    private func setVideo() {
        if let link = self.link,  let url = URL(string: link) {
            player.setVideo(resource: .init(url: url))
        }
    }
}
