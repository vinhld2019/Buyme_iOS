//
//  HeaderView.swift
//  Buyme
//
//  Created by Tran Duy on 11/28/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import SnapKit


class HeaderView: BaseView{
    
    private let txtHeader: UILabel = {
        let txt = UILabel()
        txt.font = Font.shared.bold?.withSize(23)
        return txt
        }()
    
    private let headerLayout: UIView = {
        let header = UIView()
        header.backgroundColor = UIColor(white: 1, alpha: 0)
        return header
    }()
    
    private let bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = ColorUtils.shared.gray3
        return line
    }()
    
    func setTitle(title: String){
        self.txtHeader.text = title
    }
    
    override func initViews() {
       addHeaderContent()
        addBottomLine()
    }
    
    func addHeaderContent(){
        addSubview(headerLayout)
        headerLayout.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }
               
        headerLayout.addSubview(txtHeader)
        txtHeader.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func addBottomLine(){
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
