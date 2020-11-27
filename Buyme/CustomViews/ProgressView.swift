//
//  ProgressView.swift
//  Me Click
//
//  Created by Vinh LD on 7/26/19.
//  Copyright © 2019 VinhLD. All rights reserved.
//

import UIKit

class ProgressView: BaseView {

    var contentView = UIView()

    @IBInspectable
    open var progress: CGFloat {
        get {
            return (contentView.frame.size.width / self.frame.size.width)
        }
        set {
            DispatchQueue.main.async {
                self.contentView.snp.remakeConstraints { (make) in
                    make.top.bottom.left.equalToSuperview()
                    make.width.equalToSuperview().multipliedBy(newValue)
                }
            }
        }
    }

    override func initViews() {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        self.backgroundColor = ColorUtils.shared.gray
        contentView.backgroundColor = ColorUtils.shared.green
    }
}
