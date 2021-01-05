//
//  TabBarItemView.swift
//  Buyme
//
//  Created by Vinh LD on 12/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class TabBarItemView: BaseView {
    
    var isSelected: Bool = false
    
    var imageView: UIImageView = .init()
    var label: Label = .init()
    
    @IBInspectable var image: UIImage? {
        get { imageView.image }
        set {
            DispatchQueue.main.async {
                self.imageView.image = newValue?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    @IBInspectable var text: String? {
        get { label.text }
        set {
            DispatchQueue.main.async {
                self.label.autolocalizationKey = newValue
            }
        }
    }
    
    override func initialization() {
        super.initialization()
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(label.snp.top).offset(-4)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = isSelected ? .white : ColorUtils.shared.grey2
        
        label.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(15)
        }
        label.font = Font.shared.medium?.withSize(10)
        label.textColor = isSelected ? .white : ColorUtils.shared.grey2
        label.textAlignment = .center
        
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        view.backgroundColor = ColorUtils.shared.grey1
    }
    
}
