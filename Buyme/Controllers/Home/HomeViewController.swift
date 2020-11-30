//
//  HomeViewController.swift
//  Buyme
//
//  Created by Vinh LD on 9/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var followingView: ProductPlayView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    private func addTabsView() {
//
//    }
    
    override func initViews() {
        super.initViews()
        
        view.backgroundColor = .black
        
        followingView = .init()
        view.addSubview(followingView)
        followingView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(self.view.safeAreaLayoutGuide)
        }
        followingView.link = "https://v9-vn.tiktokcdn.com/87378a7c590583da393c16e201497a03/5fc51955/video/tos/alisg/tos-alisg-pve-0037c001/e5f589f6522d4609ae48680a0a3d4dc3/"
        
        let tabsView = UIView()
        view.addSubview(tabsView)
        tabsView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
        }
        tabsView.backgroundColor = .init(rgb: 0xFFFFFF, alpha: 0.4)
        let followingLabel = Label()
        tabsView.addSubview(followingLabel)
        followingLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        followingView.player.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        followingView.player.play()
    }
    
    
    @objc func touchUpInSide(_ sender: UIButton) {
        Mics.shared.log("Touch")
        sender.setTitle(DeviceUtils.shared.wifiIPAddress, for: .normal)
    }

}
