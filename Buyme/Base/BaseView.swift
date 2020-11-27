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
        self.initialization()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialization()
    }
    
    func initViews() {
        nothingHandle()
    }
    
    func initialization() {
        DispatchQueue.main.async {
            self.initViews()
        }
    }
}

class FromNibBaseView: BaseView {
    
    @IBOutlet weak var view: UIView!
    
    override func initViews() {
        Bundle.main.loadNibNamed(Self.className, owner: self, options: nil)
        addSubview(view)
        clipsToBounds = true
        view.frame = bounds
    }
}
