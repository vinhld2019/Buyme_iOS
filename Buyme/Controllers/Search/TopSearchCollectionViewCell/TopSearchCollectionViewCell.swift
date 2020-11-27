//
//  TopSearchCollectionViewCell.swift
//  Buyme
//
//  Created by Vinh LD on 11/27/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class TopSearchCollectionViewCell: UICollectionViewCell {
    
    var titles: [String] = ["Thời Trang Nam", "Điện Thoại & Phụ Kiện", "Thiết Bị Điện Tử", "Mẹ & Bé", "Thời Trang Nữ", "Nhà Cửa & Đời Sống", "Máy tính & Laptop", "Sức Khỏe & Sắc Đẹp", "Máy ảnh - Máy quay phim", "Giày Dép Nữ"]
    var images: [String] = ["https://cf.shopee.vn/file/687f3967b7c2fe6a134a2c11894eea4b_tn",
    "https://cf.shopee.vn/file/31234a27876fb89cd522d7e3db1ba5ca_tn",
    "https://cf.shopee.vn/file/978b9e4cb61c611aaaf58664fae133c5_tn",
    "https://cf.shopee.vn/file/099edde1ab31df35bc255912bab54a5e_tn",
    "https://cf.shopee.vn/file/75ea42f9eca124e9cb3cde744c060e4d_tn",
    "https://cf.shopee.vn/file/24b194a695ea59d384768b7b471d563f_tn",
    "https://cf.shopee.vn/file/c3f3edfaa9f6dafc4825b77d8449999d_tn",
    "https://cf.shopee.vn/file/bba68b7dc2d664748dd075d500049d72_tn",
    "https://cf.shopee.vn/file/ec14dd4fc238e676e43be2a911414d4d_tn",
    "https://cf.shopee.vn/file/48630b7c76a7b62bc070c9e227097847_tn"]
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: Label!
    
    var index: Int! {
        didSet {
            imageView.setImage(link: images[index])
            label.text = titles[index]
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view.layer.cornerRadius = 5
        view.layer.borderColor = ColorUtils.shared.gray3.cgColor
        view.layer.borderWidth = 1
    }

}
