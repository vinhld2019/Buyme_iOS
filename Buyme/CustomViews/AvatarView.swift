//
//  AvatarView.swift
//  Buyme
//
//  Created by Vinh LD on 2/17/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import SnapKit

protocol AvatarViewDelegate: class {
    func touchUpInSide(_ view: AvatarView)
}

class AvatarView: BaseView {
    
    weak var delegate: AvatarViewDelegate?

    @IBInspectable var radius: CGFloat = 40
    @IBInspectable var fontSize: CGFloat = 18
    @IBInspectable var color: UIColor? {
        get {
            return label.textColor
        }
        set {
            DispatchQueue.main.async {
                self.label.textColor = newValue
            }
        }
    }

    var isShowImage: Bool {
        get {
            if let img = self.imageView {
                return !img.isHidden
            }
            return false
        }
        set {
            DispatchQueue.main.async {
                self.label.isHidden = newValue
                self.imageView.isHidden = !newValue
            }
        }
    }

    var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            DispatchQueue.main.async {
                self.imageView.image = newValue
            }
        }
    }

    var text: String? {
        get {
            return self.label.text
        }
        set {
            DispatchQueue.main.async {
                self.label.text = newValue
            }
        }
    }

    private var label: UILabel!
    private var imageView: UIImageView!

    override func initialization() {
        self.layer.cornerRadius = radius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1

        let avatarView = UIView()
        self.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = radius

        self.label = UILabel()
        avatarView.addSubview(self.label)
        label.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        label.text = "Avatar"
        label.textColor = .black
        label.textAlignment = .center
        label.font = Font.shared.medium?.withSize(fontSize)

        self.imageView = UIImageView()
        self.addSubview(self.imageView)

        let button = UIButton()
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }

    @objc func touchUpInside(_ sender: UIButton) {
        delegate?.touchUpInSide(self)
    }
}
