//
//  MessageView.swift
//  Look-up Students
//
//  Created by Vinh LD on 1/30/19.
//  Copyright © 2019 LuS Team. All rights reserved.
//

import UIKit
let kTagToastView = 1102
class MessageView: UILabel {

    var message: String? {
        get { return text }
        set { autolocalizationKey = newValue }
    }

    var startAt: Int64 = Date.currentTimeInSeconds

    override init(frame: CGRect) {
        super.init(frame: frame)
        DispatchQueue.main.async {
            self.font = Font.shared.regular?.withSize(13)
            self.backgroundColor = .gray
            self.textColor = .white
            self.layer.cornerRadius = 4
            self.numberOfLines = 0
            self.textAlignment = .center
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += 20
        return size
    }
}

extension UIView {

    func toast(message: String?) {
        var lastTime = Date.currentTimeInSeconds
        var containsMessageView = false
        for view in subviews where view is MessageView {
            containsMessageView = true
            let msgView = view as? MessageView
            let msgTime = (msgView?.startAt ?? 0) + 2001
            if lastTime < msgTime {
                lastTime = msgTime
            }
            break
        }
        var messageView: MessageView
        if containsMessageView {
            messageView = self.viewWithTag(kTagToastView) as? MessageView ?? MessageView()
        } else {
            messageView = MessageView()
            messageView.startAt = lastTime
            messageView.message = (message ?? "").localize
            messageView.tag = kTagToastView
            addSubview(messageView)
            messageView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().offset(-40)
                make.bottom.equalToSuperview().offset(-20)
            }
            messageView.cornerRadius = kAppRadius
            messageView.isHidden = containsMessageView
            
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(hideBottomMessageView(_:)), userInfo: ["message": message], repeats: false)
        }
    }

    @objc func hideBottomMessageView(_ sender: Timer) {
        let info = (sender.userInfo as? [String: Any?]) ?? [:]
        let message = info["message"] as? String
        for view in subviews where view is MessageView {
            let messageView = view as? MessageView
            if messageView?.message == message?.localize {
                messageView?.removeFromSuperview()
                break
            }
        }
    }
}
