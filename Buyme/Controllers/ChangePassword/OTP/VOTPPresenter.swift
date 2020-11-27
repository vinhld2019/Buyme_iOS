//
//  VOTPPresenter.swift
//  Retail
//
//  Created by Vinh LD on 4/2/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

protocol VOTPDelegate: class {
    
}

class VOTPPresenter: BasePresenter<VOTPDelegate> {
    func verifyOTP(otp: String) {
        print(otp)
    }
}
