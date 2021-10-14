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
    @IBOutlet weak var mostButton: UIButton!
    @IBOutlet weak var mostLineView: UIView!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var accountLineView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func changeTab(_ sender: UIButton) {
        sender.isSelected = true
        let tag = sender.tag
        if tag == 0 {
            accountButton.isSelected = false
            mostLineView.backgroundColor = .white
            accountLineView.backgroundColor = .lightGray
        } else {
            mostButton.isSelected = false
            mostLineView.backgroundColor = .lightGray
            accountLineView.backgroundColor = .white
        }
    }
    
    let recentSearch = ["Áo khoác lông", "Bốt cao cổ", "Mũ len tay", "Áo khoác dạ tweet", "Chân váy da", "Set đồ lông", "Khăn tay"]
    
    override func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.attributedPlaceholder = NSAttributedString(string: "Tìm kiếm", attributes: [.foregroundColor: UIColor.white])
        
        SearchTableViewCell.register(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = SearchTableViewCell.cell(for: tableView, at: indexPath) {
            cell.titleLabel.text = recentSearch[indexPath.row]
            return cell
        }
        return .init()
    }
}
