//
//  PostButtonView.swift
//  Buyme
//
//  Created by Vinh LD on 11/27/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol PostButtonViewDelegate: class {
    func postButtonView(touchUpInsideAt view: PostButtonView)
}

class PostButtonView: BaseView {
    
    weak var delegate: PostButtonViewDelegate?
    
    var imageView: UIImageView = .init()
    var label: Label = .init()
    
    @IBInspectable var text: String? {
        get { label.text }
        set {
            DispatchQueue.main.async {
                self.label.text = newValue
            }
        }
    }
    
    @IBInspectable var image: UIImage? {
        get { imageView.image }
        set {
            DispatchQueue.main.async {
                self.imageView.image = newValue
            }
        }
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        delegate?.postButtonView(touchUpInsideAt: self)
    }
    
    override func initViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.right.bottom.left.equalToSuperview()
        }
        label.font = Font.shared.regular?.withSize(12)
        label.textColor = .white
        label.textAlignment = .center
        
        let button = UIButton()
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
}
