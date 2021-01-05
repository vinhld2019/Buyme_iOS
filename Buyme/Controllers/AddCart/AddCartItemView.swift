//
//  AddCartItemView.swift
//  Buyme
//
//  Created by Vinh LD on 1/3/21.
//  Copyright © 2021 Vinh LD. All rights reserved.
//

import UIKit

class AddCartItemView: BaseView {
    
    var selectedImageView: UIImageView!
    var label: UILabel = .init()
    
    var group: AddCartGroup?
    var isSelected: Bool = false
    
    @IBInspectable var text: String? {
        get { label.text }
        set {
            DispatchQueue.main.async {
                self.label.text = newValue
            }
        }
    }
    
    override func initialization() {
        backgroundColor = ColorUtils.shared.grey2
        cornerRadius = 2
        borderColor = ColorUtils.shared.red
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        label.font = Font.shared.regular?.withSize(12)
        label.textColor = .white
        label.textAlignment = .center
        
        selectedImageView = .init(image: UIImage(named: "ACItemSelected"))
        addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(16)
            make.height.equalTo(13)
        }
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.isHidden = true
        
        let button = UIButton()
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        group?.selection(at: self)
    }
    
    func refresh() {
        if isSelected {
            backgroundColor = .white
            borderWidth = 1
            label.textColor = .black
            selectedImageView.isHidden = false
        } else {
            backgroundColor = ColorUtils.shared.grey2
            borderWidth = 0
            label.textColor = .white
            selectedImageView.isHidden = true
        }
    }
}

class AddCartGroup {
    
    var items: [AddCartItemView] = []
    
    init(_ items: [AddCartItemView] = []) {
        for item in items {
            self.register(item: item)
        }
    }
    
    func selection(at view: AddCartItemView) {
        for item in items {
            item.isSelected = item == view
            item.refresh()
        }
    }
    
    func register(item: AddCartItemView) {
        items.append(item)
        item.group = self
    }
}
