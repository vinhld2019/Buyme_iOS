//
//  HorizontalMenuItemView.swift
//  Buyme
//
//  Created by Vinh LD on 12/29/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class HorizontalMenuItemView: BaseView {
    
    var selection: (() -> Void)?
    
    var label: UILabel = .init()
    
    @IBInspectable var text: String? {
        get { label.text }
        set {
            DispatchQueue.main.async {
                self.label.text = newValue
            }
        }
    }
    
    override func initialization() {
        super.initialization()
        
        layer.cornerRadius = 2
        layer.masksToBounds = true
        layer.borderColor = ColorUtils.shared.grey2.cgColor
        layer.borderWidth = 1
        
        label = UILabel()
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(35)
        }
        label.textColor = .white
        label.font = Font.shared.bold?.withSize(12)
        label.text = text
        
        let button = UIButton()
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
    
    init(text: String?) {
        super.init(frame: .zero)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        selection?()
    }
}
