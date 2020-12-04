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

class ProductPlayView: BaseView {
    
    let kShareTag: Int = 0
    let kCommentTag: Int = 1
    let kHeartTag: Int = 2
    let kCartTag: Int = 3
    
    var player: BMPlayer!
    var nameLabel: Label = .init()
    var descriptionLabel: Label = .init()
    
    var name: String? {
        get { nameLabel.text }
        set { nameLabel.text = newValue }
    }
    
    var detail: String? {
        get { descriptionLabel.text }
        set { descriptionLabel.text = newValue }
    }
    
    @objc func categoryTouchUpInside(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            AppUtils.shared.pushViewController(typeClass: SearchWithCategoriesViewController.self)
            
        default:
            AppUtils.shared.pushViewController(typeClass: SearchWithCategoriesViewController.self)
        }
    }
    
    private func addCategory(superView: UIView, title: String, tag: Int, left: ConstraintItem) -> UIView {
        let view: UIView = .init()
        superView.addSubview(view)
        view.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.left.equalTo(left).offset(10)
        }
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.cornerRadius = 2
        let currentCatLabel = Label()
        view.addSubview(currentCatLabel)
        currentCatLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        currentCatLabel.font = Font.shared.bold?.withSize(13)
        currentCatLabel.textColor = .white
        currentCatLabel.text = title
        
        let button = UIButton()
        button.tag = tag
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(categoryTouchUpInside(_:)), for: .touchUpInside)
        
        return view
    }
    
    private func addButtonAction(superView: UIView, image: String, tag: Int = 0,
                                 bottom: ConstraintItem, bottomOffest: CGFloat = -5,
                                 height: CGFloat = 60, text: String? = "0") -> PostButtonView {
        let view = PostButtonView.init()
        superView.addSubview(view)
        view.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(bottom).offset(bottomOffest)
            make.width.equalTo(60)
            make.height.equalTo(height)
        }
        view.image = UIImage(named: image)
        view.tag = tag
        view.text = text
        view.delegate = self
        
        return view
    }
    
    override func initViews() {
        player = .init()
        self.addSubview(player)
        player.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
        let button = UIButton()
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
        
        let categoryView = UIView()
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(60)
            make.right.left.equalToSuperview()
            make.height.equalTo(60)
        }
        
        let currentCat = addCategory(superView: categoryView, title: "Thời Trang", tag: 0, left: categoryView.snp.left)
        _ = addCategory(superView: categoryView, title: "Danh mục khác", tag: 1, left: currentCat.snp.right)
        
        let detailView = UIView()
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-60)
            make.bottom.equalTo(view).offset(-10)
            make.left.equalTo(view).offset(10)
        }
        detailView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(30)
        }
        nameLabel.font = Font.shared.bold?.withSize(13)
        nameLabel.textColor = .white
        nameLabel.text = "Thỏ Béo 1,5 tấn"
        
        detailView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.right.bottom.left.equalToSuperview()
        }
        descriptionLabel.font = Font.shared.regular?.withSize(12)
        descriptionLabel.textColor = .white
        descriptionLabel.text = "Sáng 27-11, tại Hà Nội,Tổng Bí thư, Chủ tịch nước Nguyễn Phú Trọng dự và phát biểu chỉ đạo Hội nghị toàn quốc tổng kết công tác kiểm tra, giám sát nhiệm kỳ Đại hội XII của Đảng do Ban Bí thư tổ chức."
        descriptionLabel.numberOfLines = 0
        
        let shareView = addButtonAction(superView: view, image: "PostShare", bottom: view.snp.bottom, bottomOffest: 0)
        let commentView = addButtonAction(superView: view, image: "PostMessage", tag: kCommentTag, bottom: shareView.snp.top)
        let heartView = addButtonAction(superView: view, image: "PostHeart", tag: kHeartTag, bottom: commentView.snp.top)
        _ = addButtonAction(superView: view, image: "PostAddToCart", tag: kCartTag, bottom: heartView.snp.top, height: 40, text: nil)
        
//        setVideo(link: "18065816251741380939")
//        setVideo(link: "https://v16.tiktokcdn.com/cead4b93cb85c6c30bb257eeb2fd1a58/5fc65010/video/tos/alisg/tos-alisg-pve-0037c001/297ea804a28a46fcaba8afe223badc8a/")
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
    
    @objc func touchUpInside(_ sender: UIButton) {
        player.isPlaying ? player.pause() : player.play()
    }
}

extension ProductPlayView: PostButtonViewDelegate {
    func postButtonView(touchUpInsideAt view: PostButtonView) {
        let tag = view.tag
        switch tag {
        case kShareTag:
            let vc = UIActivityViewController(activityItems: ["https://www.facebook.com/vnvinhld"], applicationActivities: nil)
            AppUtils.shared.present(vc, animated: true)
            
        case kHeartTag:
            view.image = view.image?.withRenderingMode(.alwaysTemplate)
            view.imageView.tintColor = .red
            
        case kCartTag:
            self.superSuperview.addToCartShow()
            
        default:
            break
        }
    }
}
