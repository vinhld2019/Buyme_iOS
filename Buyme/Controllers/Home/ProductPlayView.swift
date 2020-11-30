//
//  ProductPlayView.swift
//  Buyme
//
//  Created by Vinh LD on 11/30/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import BMPlayer

class ProductPlayView: BaseView {
    
    var player: BMPlayer!
    var link: String?
    
    override func initViews() {
        player = .init()
        self.addSubview(player)
        player.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        
        self.setVideo()
        
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
        let categoryView = UIView()
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(60)
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
            make.right.equalTo(view).offset(-60)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
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
            make.right.bottom.equalTo(view)
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
        
    }
    
    private func setVideo() {
        //ß
        if let link = self.link, let url = URL(string: link) {
            player.setVideo(resource: .init(url: url))
        }
    }
}

extension ProductPlayView: PostButtonViewDelegate {
    func postButtonView(touchUpInsideAt view: PostButtonView) {
        let tag = view.tag
        switch tag {
        case 2:
            view.image = view.image?.withRenderingMode(.alwaysTemplate)
            view.imageView.tintColor = .red
            
        default:
            break
        }
    }
}
