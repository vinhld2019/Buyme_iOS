//
//  HomeViewController.swift
//  Buyme
//
//  Created by Vinh LD on 9/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var followingView: FollowingView!

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
        followingView.link = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        
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
        
        let categoryView = UIView()
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(tabsView.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        let currentCatView: UIView = .init()
        categoryView.addSubview(currentCatView)
        currentCatView.snp.makeConstraints { make in
            make.centerY.left.equalToSuperview()
            make.height.equalTo(30)
        }
        currentCatView.layer.borderColor = ColorUtils.shared.appColor.cgColor
        currentCatView.layer.borderWidth = 1
        currentCatView.cornerRadius = 2
        let currentCatLabel = Label()
        currentCatView.addSubview(currentCatLabel)
        currentCatLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        currentCatLabel.font = Font.shared.bold?.withSize(13)
        currentCatLabel.textColor = ColorUtils.shared.appColor
        currentCatLabel.text = "Thịt thỏ"
        
        let otherCatView: UIView = .init()
        categoryView.addSubview(otherCatView)
        otherCatView.snp.makeConstraints { make in
            make.left.equalTo(currentCatView.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
        otherCatView.layer.borderColor = ColorUtils.shared.appColor.cgColor
        otherCatView.layer.borderWidth = 1
        otherCatView.cornerRadius = 2
        let otherCatLabel = Label()
        otherCatView.addSubview(otherCatLabel)
        otherCatLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        otherCatLabel.font = Font.shared.bold?.withSize(13)
        otherCatLabel.textColor = ColorUtils.shared.appColor
        otherCatLabel.text = "Thịt khác"
        
        let detailView = UIView()
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-60)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(10)
        }
        let nameLabel: Label = .init()
        detailView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(30)
        }
        nameLabel.font = Font.shared.bold?.withSize(13)
        nameLabel.textColor = .white
        nameLabel.text = "Thỏ Béo 1,5 tấn"
        let detailLabel = Label.init()
        detailView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.right.bottom.left.equalToSuperview()
        }
        detailLabel.font = Font.shared.regular?.withSize(12)
        detailLabel.textColor = .white
        detailLabel.text = "Sáng 27-11, tại Hà Nội,Tổng Bí thư, Chủ tịch nước Nguyễn Phú Trọng dự và phát biểu chỉ đạo Hội nghị toàn quốc tổng kết công tác kiểm tra, giám sát nhiệm kỳ Đại hội XII của Đảng do Ban Bí thư tổ chức."
        detailLabel.numberOfLines = 0
        
        let shareView = PostButtonView.init()
        view.addSubview(shareView)
        shareView.snp.makeConstraints { make in
            make.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.width.height.equalTo(60)
        }
        shareView.image = UIImage(named: "PostShare")
        shareView.text = "0"
        shareView.tag = 0
        shareView.delegate = self
        
        let commentView = PostButtonView.init()
        view.addSubview(commentView)
        commentView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(shareView.snp.top).offset(-5)
            make.width.height.equalTo(60)
        }
        commentView.image = UIImage(named: "PostMessage")
        commentView.text = "0"
        commentView.tag = 1
        commentView.delegate = self
        
        let heartView = PostButtonView.init()
        view.addSubview(heartView)
        heartView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(commentView.snp.top).offset(-5)
            make.width.height.equalTo(60)
        }
        heartView.image = UIImage(named: "PostHeart")
        heartView.text = "0"
        heartView.tag = 2
        heartView.delegate = self
        
        let addCartView = PostButtonView.init()
        view.addSubview(addCartView)
        addCartView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(heartView.snp.top).offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        addCartView.image = UIImage(named: "PostAddToCart")
        heartView.tag = 3
        heartView.delegate = self
        
//
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        followingView.player.player.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        followingView.player.player.play()
    }
    
    
    @objc func touchUpInSide(_ sender: UIButton) {
        Mics.shared.log("Touch")
        sender.setTitle(DeviceUtils.shared.wifiIPAddress, for: .normal)
    }

}
