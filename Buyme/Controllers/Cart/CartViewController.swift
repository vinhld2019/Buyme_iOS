//
//  CartViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func selectCart(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func buy(_ sender: UIButton) {
        navigationController?.pushViewController(ThanhToanViewController(), animated: true)
    }
    
    var sellers: [Seller] = [Seller(name: "@Lan Cây", image: "LanCave", products: [Product(), Product()]),
                             Seller(name: "@Dakota Johnson", image: "DakotaJohnson", products: [Product(), Product()])]

    override func viewDidLoad() {
        super.viewDidLoad()

        CartTableViewCell.register(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sellers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sellers[section].products.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let seller = sellers[section]
        
        let header = UIView()
        header.backgroundColor = .init(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        
        let view = UIView()
        header.addSubview(view)
        view.backgroundColor = .init(rgb: 0x121212)
        view.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        let image = UIImageView()
        header.addSubview(image)
        image.image = .init(named: seller.image!)
        image.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(10)
            $0.width.height.equalTo(40)
        }
        image.contentMode = .scaleAspectFit
        image.cornerRadius = 20
        
        let label = UILabel()
        header.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.equalTo(image.snp.right).offset(10)
        }
        label.text = seller.name
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        
        let button = UIButton(type: .system)
        header.addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.right.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
        button.setImage(.init(named: "CommentClose"), for: .normal)
        button.tintColor = .white
        
        let view1 = UIView()
        header.addSubview(view1)
        view1.backgroundColor = .init(rgb: 0x121212)
        view1.snp.makeConstraints {
            $0.right.bottom.left.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CartTableViewCell.cell(for: tableView, at: indexPath)!
        return cell
    }
}
