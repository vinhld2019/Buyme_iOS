//
//  HorizontalMenuView.swift
//  Buyme
//
//  Created by Vinh LD on 12/29/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class HorizontalMenuView: BaseView {
    var scrollView: UIScrollView!
    
    var datasource: [String] = ["Thời trang", "Điện thoại iPhone 12 Pro Max", "Đồng hồ", "Máy tính", "Phụ kiện"]
    
    func reloadDatas() {
        var lastView: UIView?
        for index in 0...datasource.count-1 {
            let data = datasource[index]
            let view = HorizontalMenuItemView(text: data)
            scrollView.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                if index == 0 {
                    make.left.equalToSuperview()
                } else if let last = lastView {
                    make.left.equalTo(last.snp.right).offset(10)
                }
                if index == datasource.count-1 {
                    make.right.equalToSuperview()
                }
            }
            view.tag = index
            view.selection = {
                self.menu(didSelect: view)
            }
            lastView = view
        }
    }
    
    private func menu(didSelect item: HorizontalMenuItemView) {
        print(item.tag)
    }
    
    override func initialization() {
        super.initialization()
        scrollView = UIScrollView(frame: bounds)
        addSubview(scrollView)
    }
}
