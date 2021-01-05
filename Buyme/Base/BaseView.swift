//
//  BaseView.swift
//  Corporate
//
//  Created by Vinh LD on 5/15/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        DispatchQueue.main.async {
            self.initialization()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        DispatchQueue.main.async {
            self.initialization()
        }
    }
    
    func initialization() {
        backgroundColor = .clear
    }
    
    func open(completion: ((Bool) -> Void)? = nil) {
        Self.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = 0
            self.frame.origin.y = 0
        }, completion: { success in
            self.frame.origin.x = 0
            self.frame.origin.y = 0
            completion?(success)
        })
    }
    
    func close(x: CGFloat = 0, y: CGFloat = 0, completion: ((Bool) -> Void)? = nil) {
        Self.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = x
            self.frame.origin.y = y
        }, completion: { success in
            self.frame.origin.x = x
            self.frame.origin.y = y
            completion?(success)
        })
    }
}

class FromNibBaseView: BaseView {
    
    @IBOutlet weak var view: UIView!
    
    override func initialization() {
        Bundle.main.loadNibNamed(Self.className, owner: self, options: nil)
        addSubview(view)
        clipsToBounds = true
        view.frame = bounds
    }
}
