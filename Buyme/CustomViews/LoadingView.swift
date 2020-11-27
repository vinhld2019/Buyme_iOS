//
//  LoadingView.swift
//  Look-up Students
//
//  Created by Vinh LD on 1/30/19.
//  Copyright © 2019 LuS Team. All rights reserved.
//

import UIKit

class LoadingView: UIActivityIndicatorView {

    convenience init() {
        self.init(style: .whiteLarge)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        setup()
    }

    func setup() {
        DispatchQueue.main.async {
            self.backgroundColor = UIColor(rgb: 0x000000, alpha: 0.4)
            self.color = ColorUtils.shared.appColor
            self.startAnimating()
        }
    }
}

extension UIView {
    func showLoading(tag: Int = 0) {
        DispatchQueue.main.async {
            let loadingView = LoadingView()
            loadingView.tag = tag
            self.addSubview(loadingView)
            loadingView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }
        }
    }

    func hideLoading(tag: Int = 0) {
        for view in subviews where view is LoadingView && tag == view.tag {
            view.removeFromSuperview()
        }
    }
}
