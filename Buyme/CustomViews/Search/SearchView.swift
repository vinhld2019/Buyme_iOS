//
//  SearchView.swift
//  Buyme
//
//  Created by Vinh LD on 12/29/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class SearchView: BaseView {
    
    var selection: (() -> Void)?
    
    var label = Label()
    
    @IBInspectable var placeholder: String? {
        didSet {
            label.text = placeholder
        }
    }
    
    override func initialization() {
        backgroundColor = ColorUtils.shared.grey1
        cornerRadius = 2
        
        let image = UIImageView(image: UIImage(named: "SearchViewIcon"))
        addSubview(image)
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(18)
        }
        image.contentMode = .scaleAspectFit
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(image.snp.right).offset(5)
        }
        label.font = Font.shared.regular?.withSize(14)
        label.textColor = ColorUtils.shared.grey3
        label.text = "Tìm kiếm"
        
        let button = UIButton()
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        selection?()
    }
}
