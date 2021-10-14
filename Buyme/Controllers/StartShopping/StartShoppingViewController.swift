//
//  StartShoppingViewController.swift
//  UBuy
//
//  Created by Vinh LD on 3/29/21.
//  Copyright © 2021 Vinh LD. All rights reserved.
//

import UIKit

class StartShoppingViewController: UIViewController {
    
    @IBOutlet weak var moiConstraint: NSLayoutConstraint!
    @IBOutlet weak var cuConstraint: NSLayoutConstraint!
    @IBOutlet weak var hieuConstraint: NSLayoutConstraint!
    
    @IBAction func moi(_ sender: UIButton) {
        moiConstraint.constant -= sender.isSelected ? -40 : 40
        sender.isSelected = !sender.isSelected
        hasNew = sender.isSelected
    }
    
    @IBAction func cu(_ sender: UIButton) {
        cuConstraint.constant -= sender.isSelected ? -40 : 40
        sender.isSelected = !sender.isSelected
        hasOld = sender.isSelected
    }
    
    @IBAction func hieu(_ sender: UIButton) {
        hieuConstraint.constant -= sender.isSelected ? -40 : 40
        sender.isSelected = !sender.isSelected
        hasStore = sender.isSelected
    }
    
    @IBAction func startShopping(_ sender: UIButton) {
        if !linkIsValid { return }
        navigationController?.pushViewController(TabBarViewController(), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
