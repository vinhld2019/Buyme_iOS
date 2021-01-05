//
//  AddCartViewController.swift
//  Buyme
//
//  Created by Vinh LD on 1/3/21.
//  Copyright © 2021 Vinh LD. All rights reserved.
//

import UIKit

class AddCartViewController: UIViewController {
    
    @IBOutlet weak var pl: AddCartItemView!
    @IBOutlet weak var pl1: AddCartItemView!
    @IBOutlet weak var pl2: AddCartItemView!
    @IBOutlet weak var size: AddCartItemView!
    @IBOutlet weak var size1: AddCartItemView!
    @IBOutlet weak var size2: AddCartItemView!
    @IBOutlet weak var size3: AddCartItemView!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func change(_ sender: UIButton) {
        let tag = sender.tag
        if tag == 0 {
            number -= 1
        } else {
            number += 1
        }
        
        if number < 1 {
            number = 1
        }
        
        numberLabel.text = "\(number)"
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var number: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = AddCartGroup([pl, pl1, pl2])
        _ = AddCartGroup([size, size1, size2, size3])
    }

}
