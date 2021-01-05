//
//  PlayerButton.swift
//  Buyme
//
//  Created by Vinh LD on 12/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol PlayerButtonDelegate: class {
    func playerButton(touchAt button: PlayerButton)
}

class PlayerButton: BaseView {
    
    weak var delegate: PlayerButtonDelegate?

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
                self.label.text = newValue
            }
        }
    }
    
    var isSelected: Bool = false
    
    override func initialization() {
        super.initialization()
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(label.snp.top).offset(-5)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        label.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(20)
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
    
    @objc func touchUpInside(_ sender: UIButton) {
        delegate?.playerButton(touchAt: self)
    }

}
