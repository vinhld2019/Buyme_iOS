//
//  BasePresenter.swift
//  Buyme
//
//  Created by Vinh LD on 2/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol BaseDelegate {
}

extension BaseDelegate {
}

class BasePresenter<D>: NSObject {
    var delegate: D?
    
    public init(delegate: D) {
        self.delegate = delegate
    }
    
    func attachDelegate(delegate: D) {
        self.delegate = delegate
    }
    
    func attachDelegateIfNeed(delegate: D) {
        if !isDelegateAttached {
            self.delegate = delegate
        }
    }
    
    func detachDelegate() {
        self.delegate = nil
    }
    
    var isDelegateAttached: Bool {
        return self.delegate != nil
    }
}
