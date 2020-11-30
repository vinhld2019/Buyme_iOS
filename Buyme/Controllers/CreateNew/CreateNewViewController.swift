//
//  CreateNewViewController.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesomeKit

class CreateNewViewController: BaseViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.className, for: indexPath) as? CartItemTableViewCell {
            return cell
        }
        return .init()
    }
    
    
    
    let data = ["123","123","123"]
    
    private var header: HeaderView = {
       let header = HeaderView()
        header.setTitle(title: "Cart")
        return header
    }()
    
    private var tableView: UITableView!
    
    private var bottomView: UIView!

    override func viewDidLoad() {
     
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func initViews() {
        super.initViews()

        view.addSubview(header)
        header.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        addBottomView()
        addTableView()
    }
    
    func addTableView(){
        tableView = UITableView()
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.register(CartItemTableViewCell.nib, forCellReuseIdentifier: CartItemTableViewCell.className)
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
    
    @objc func payButtonOnClick(sender: UIButton!) {
        
    }
    
    func addBottomView(){
        bottomView = UIView()
        bottomView.backgroundColor = UIColor(red: 242, green: 242, blue: 245)
        view.addSubview(bottomView)
        
        let leftBottomView = UIView()
        leftBottomView.backgroundColor = .white
        leftBottomView.cornerRadius = 8
        bottomView.addSubview(leftBottomView)
        
        let payButton = UIButton()
        payButton.setTitle("Pay", for: .normal)
        payButton.addTarget(self, action: #selector(payButtonOnClick), for: .touchUpInside)
        payButton.backgroundColor = ColorUtils.shared.appColor
        payButton.cornerRadius = 4
        bottomView.addSubview(payButton)
        payButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
            make.height.equalTo(leftBottomView.snp.height)
            make.width.equalTo(70)
            
        }
        
        let subTotalLable = UILabel()
        subTotalLable.text = "Subtotal"
        subTotalLable.font = Font.shared.bold?.withSize(14)
        subTotalLable.textColor = ColorUtils.shared.gray2
        
        let subTotal = UILabel()
        subTotal.text = "$120.00"
        subTotal.font = Font.shared.bold?.withSize(14)
        subTotal.textColor = ColorUtils.shared.gray2
        
        let discountLable = UILabel()
        discountLable.text = "Discount"
        discountLable.font = Font.shared.bold?.withSize(14)
        discountLable.textColor = ColorUtils.shared.gray2
               
        let discount = UILabel()
        discount.text = "$1.00"
        discount.font = Font.shared.bold?.withSize(14)
        discount.textColor = ColorUtils.shared.gray2
                    
        let totalCountLable = UILabel()
        totalCountLable.text = "Total count:"
        totalCountLable.font = Font.shared.bold?.withSize(14)
              
        let totalCount = UILabel()
        totalCount.text = "$1000"
        totalCount.font = Font.shared.bold?.withSize(14)
       
        leftBottomView.addSubview(subTotalLable)
        subTotalLable.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(14)
        }
        
        leftBottomView.addSubview(subTotal)
        subTotal.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-14)
            make.centerY.equalTo(subTotalLable)
        }
        
        leftBottomView.addSubview(discountLable)
        discountLable.snp.makeConstraints { (make) in
            make.top.equalTo(subTotalLable.snp.bottom).offset(4)
            make.left.equalTo(subTotalLable.snp.left)
        }
        
        leftBottomView.addSubview(discount)
        discount.snp.makeConstraints { (make) in
           make.right.equalTo(subTotal.snp.right)
            make.centerY.equalTo(discountLable)
        }
        
        leftBottomView.addSubview(totalCountLable)
        totalCountLable.snp.makeConstraints { (make) in
            make.top.equalTo(discountLable.snp.bottom).offset(4)
            make.left.equalTo(subTotalLable.snp.left)
            make.bottom.equalToSuperview().offset(-14)
            
        }
        
        leftBottomView.addSubview(totalCount)
        totalCount.snp.makeConstraints { (make) in
            make.centerY.equalTo(totalCountLable)
            make.right.equalTo(subTotal.snp.right)
        }
        
        leftBottomView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.right.equalTo(payButton.snp.left).offset(-14)
            make.centerY.equalToSuperview()
//            make.height.equalTo(30)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}
