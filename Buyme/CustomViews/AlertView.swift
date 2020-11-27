//
//  AlertView.swift
//  Buyme
//
//  Created by Vinh LD on 2/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

enum AlertViewType {
    case alert
    case confirm
}

protocol AlertViewDelegate: class {
    func alertViewClose(_ view: AlertView)
    func alertViewOk(_ view: AlertView)
}

extension AlertViewDelegate {
    func alertViewClose(_ view: AlertView) {
        nothingHandle(view: view)
    }
    func alertViewOk(_ view: AlertView) {
        nothingHandle(view: view)
    }
}

class AlertView: BaseView {
    
    var okTitle: String?
    var cancelTitle: String?
    
    var type: AlertViewType = .alert
    var title: String?
    var content: String?
    var contentView: UIView?
    
    weak var delegate: AlertViewDelegate?
    
    override func initViews() {
        self.backgroundColor = .clear
        let closeButton = UIButton()
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalToSuperview()
        }
        closeButton.addTarget(self, action: #selector(touchUpInBackground(_:)), for: .touchUpInside)
        
        let view = UIView()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        view.backgroundColor = .white
        view.layer.cornerRadius = kAppRadius
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        titleLabel.font = Font.shared.medium?.withSize(16)
        titleLabel.textColor = ColorUtils.shared.appColor
        titleLabel.textAlignment = .center
        titleLabel.autolocalizationKey = self.title
        
        if let contentView = contentView {
            view.addSubview(contentView)
            contentView.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom)
                make.left.right.bottom.equalToSuperview().offset(-70)
            }
        } else {
            let messageLabel = UILabel()
            view.addSubview(messageLabel)
            messageLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom)
                make.centerX.equalToSuperview()
                make.left.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-70)
            }
            messageLabel.font = Font.shared.regular
            messageLabel.autolocalizationKey = self.content
            messageLabel.textAlignment = .center
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0
        }
        
        let button = UIButton()
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.leftMargin.equalTo(10)
            make.rightMargin.equalTo(10)
            make.height.equalTo(40)
        }
        button.backgroundColor = ColorUtils.shared.appColor
        button.autolocalizationKey = self.okTitle ?? "Ok"
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        button.layer.cornerRadius = kAppRadius
        button.titleLabel?.font = Font.shared.medium
        
        if self.type == .confirm {
            let okButton = UIButton()
            view.addSubview(okButton)
            okButton.snp.makeConstraints { (make) in
                make.bottom.right.equalToSuperview().offset(-10)
                make.left.equalTo(view.snp.centerX).offset(5)
                make.height.equalTo(40)
            }
            okButton.backgroundColor = ColorUtils.shared.appColor
            okButton.autolocalizationKey = self.okTitle ?? "Ok"
            okButton.addTarget(self, action: #selector(ok(_:)), for: .touchUpInside)
            okButton.layer.cornerRadius = kAppRadius
            okButton.titleLabel?.font = Font.shared.medium
            
            button.autolocalizationKey = self.cancelTitle ?? "Cancel"
            button.snp.remakeConstraints { (make) in
                make.bottom.top.width.equalTo(okButton)
                make.right.equalTo(okButton.snp.left).offset(-10)
                make.height.equalTo(40)
            }
            button.backgroundColor = .gray
        }
    }
    
    @objc func touchUpInBackground(_ sender: UIButton) {
        if self.delegate == nil {
            self.close()
        }
    }
    
    @objc func close(_ sender: UIButton) {
        self.close()
        self.delegate?.alertViewClose(self)
    }
    
    func close() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = -self.frame.size.height
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    @objc func ok(_ sender: UIButton) {
        self.close()
        self.delegate?.alertViewOk(self)
    }
}

extension UIView {
    var isShowwingAlert: Bool {
        for view in subviews where view is AlertView {
            return true
        }
        return false
    }
    
    func showAlert(tag: Int = 0, type: AlertViewType = .alert, title: String? = "Mobile Banking", content: String? = nil, contentView: UIView? = nil, okButton: String? = "Close", cancel: String? = "Cancel", delegate: AlertViewDelegate? = nil) {
        DispatchQueue.main.async {
            let alert = AlertView()
            alert.tag = tag
            alert.okTitle = okButton
            alert.cancelTitle = cancel
            alert.type = type
            alert.title = title
            alert.content = content
            alert.contentView = contentView
            alert.delegate = delegate
            alert.frame = CGRect(x: 0, y: -self.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height)
            let isShowwing = self.isShowwingAlert
            self.addSubview(alert)
            UIView.animate(withDuration: 0.3, animations: {
                alert.frame = self.bounds
            }, completion: { _ in
                alert.frame = self.bounds
                alert.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: isShowwing ? 0 : 0.6)
            })
        }
    }
}
