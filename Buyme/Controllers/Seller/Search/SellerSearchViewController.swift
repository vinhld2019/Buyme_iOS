//
//  SellerSearchViewController.swift
//  Buyme
//
//  Created by Vinh LD on 27/09/2021.
//  Copyright © 2021 Vinh LD. All rights reserved.
//

import UIKit

class SellerSearchViewController: BaseViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction override func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.attributedPlaceholder = NSAttributedString(string: "Tìm kiếm", attributes: [.foregroundColor: UIColor.white])

        SellerSearchTableViewCell.register(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        SellerShopCollectionViewCell.register(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SellerSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isHidden { return }
        UIView.animate(withDuration: 0.3) {
            self.textField.text = "Hàng mới về 2021"
            self.titleLabel.text = "Kết quả (7)"
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
        }
    }
}

extension SellerSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = SellerSearchTableViewCell.cell(for: tableView, at: indexPath) {
            return cell
        }
        return .init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
}

extension SellerSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - 10) / 3
        return .init(width: width, height: width * 146 / 124)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ProductViewController(), animated: true)
    }
}

extension SellerSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = SellerShopCollectionViewCell.cell(for: collectionView, at: indexPath) {
            return cell
        }
        
        return .init()
    }
}
