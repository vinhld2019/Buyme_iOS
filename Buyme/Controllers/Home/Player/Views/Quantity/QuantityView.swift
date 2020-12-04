//
//  QuantityView.swift
//  Buyme
//
//  Created by Vinh LD on 12/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class QuantityView: FromNibBaseView {

    @IBOutlet weak var textField: TextField!
    
    @IBAction func quantityChange(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if quantity > 0 {
                quantity -= 1
            }
        default:
            quantity += 1
        }
    }
    
    var quantity: Int = 1 {
        didSet {
            textField.text = "\(quantity)"
        }
    }
    
    override func initViews() {
        super.initViews()
        textField.delegate = self
    }

}

extension QuantityView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        if let text = textField.text, let quantity = Int(text) {
            self.quantity = quantity
        }
        return true
    }
}
