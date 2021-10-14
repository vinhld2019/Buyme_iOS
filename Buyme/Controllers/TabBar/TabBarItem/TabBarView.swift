//
//  TabBarView.swift
//  Buyme
//
//  Created by Vinh LD on 12/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class TabBarView: BaseView {
    
    var items: [TabBarItemView] = []
    
    override func initialization() {
        super.initialization()
        
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(100)
        }
        view.backgroundColor = .black
        
        let titles: [String] = ["Home", "Discover", "Cart", "Personal"]
        let images: [String] = ["TBIHome", "TBIDiscover", "TBICart", "TBIPersonal"]
        
        for index in 0...titles.count-1 {
            let item: TabBarItemView = .init()
            if index > 1 {
                item.badge = index * 3
            }
            addSubview(item)
            item.image = UIImage(named: images[index])
            item.text = titles[index]
            item.isSelected = index == tag
            items.append(item)
            
            item.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                if index == 0 {
                    make.left.equalToSuperview()
                } else {
                    make.width.equalTo(items[index-1])
                    make.left.equalTo(items[index-1].snp.right)
                    if index == titles.count-1 {
                        make.right.equalToSuperview()
                    }
                }
            }
        }
    }
}
