//
//  SearchViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/29/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.attributedPlaceholder = NSAttributedString(string: "Tìm kiếm", attributes: [.foregroundColor: UIColor.white])
    }

}
