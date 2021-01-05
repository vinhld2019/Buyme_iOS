//
//  DropDownView.swift
//  Buyme
//
//  Created by Vinh LD on 2/19/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import DropDown

protocol DropDownViewDelegate: class {
    func selectionHandle(_ view: DropDownView, index: Int, value: String)
}

class DropDownView: BaseView {

    weak var delegate: DropDownViewDelegate?
    var selectionAction: SelectionClosure? {
        get {
            return dropDown.selectionAction
        }
        set {
            dropDown.selectionAction = { index, value in
                newValue?(index, value)
                self.text = value
            }
        }
    }
    var datasource: [String] {
        get {
            return self.dropDown.dataSource
        }
        set {
            let dts: [String] = newValue.map { $0.localize }
            self.dropDown.dataSource = dts
            self.text = dts.first
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

    var dropDown = DropDown()
    var label: Label!
    var imageView: UIImageView!

    override func initialization() {
        self.layer.cornerRadius = kAppRadius
        self.layer.borderColor = UIColor(rgb: 0xBDBDBD).cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .white
        self.dropDown.anchorView = self

        self.label = Label()
        self.addSubview(self.label)
        self.label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-29)
            make.top.bottom.equalToSuperview()
        }
        self.label.textAlignment = .left
        self.label.autolocalizationKey = self.text
        self.label.font = Font.shared.regular
        self.label.textColor = ColorUtils.shared.gray
        label.fitToWitdh()

        self.imageView = UIImageView(image: UIImage(named: "ArrowDown"))
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(14)
            make.height.equalTo(8)
        }
        imageView.contentMode = .scaleAspectFit
        let button = UIButton()
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(handle(_:)), for: .touchUpInside)

        if selectionAction == nil {
            dropDown.selectionAction = {(index, value) in
                self.text = value
                self.delegate?.selectionHandle(self, index: index, value: value)
            }
        }
    }

    @objc func handle(_ sender: UIButton) {
        self.dropDown.show()
    }
}
