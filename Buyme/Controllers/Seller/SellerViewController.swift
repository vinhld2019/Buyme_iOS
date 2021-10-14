//
//  SellerViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class SellerViewController: BaseViewController {
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var vuaxemCollectionView: UICollectionView!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    
    @IBOutlet weak var hightlightButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var danhmucButton: UIButton!
    private lazy var buttons: [UIButton] = { [shopButton, danhmucButton] }()
    
    @IBAction func follow(_ sender: UIButton) {
        let selected = !sender.isSelected
        sender.isSelected = selected
        sender.backgroundColor = selected ? ColorUtils.shared.red : .white
    }
    
    override func back(_ sender: UIButton) {
        if let action = backAction {
            action()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func changeTab(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.hightlightButtonLeadingConstraint.constant = sender.frame.origin.x
        }

        let tag = sender.tag
        for button in buttons {
            button.isSelected = button.tag == tag
        }
        shopCollectionView.reloadData()
    }
    
    var backAction: (() -> Void)?
    var videos: [Video] { randomVideos }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.selection = {
            self.navigationController?.pushViewController(SellerSearchViewController(), animated: true)
        }
        
        ProductListCollectionViewCell.register(vuaxemCollectionView)
        SellerShopCollectionViewCell.register(shopCollectionView)
        DanhMucCollectionViewCell.register(shopCollectionView)
    }

}

extension SellerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = collectionView.tag
        if tag == 0 {
            return .init(width: 100, height: 120)
        }
        
        if tag == 1 {
            if shopButton.isSelected {
                let width = (collectionView.bounds.size.width - 10) / 3
                return .init(width: width, height: width * 146 / 124)
            }
            if danhmucButton.isSelected {
                return .init(width: collectionView.bounds.size.width, height: 70)
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = collectionView.tag
        if tag == 1 {
            if danhmucButton.isSelected {
                navigationController?.pushViewController(DanhMucViewController(), animated: true)
                return
            }
        }
        navigationController?.pushViewController(ProductViewController(), animated: true)
    }
}

extension SellerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        if tag == 0 { return videos.count }
        
        if tag == 1 {
            if shopButton.isSelected {
                return 100
            }
            if danhmucButton.isSelected {
                return 7
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        if tag == 0, let cell = ProductListCollectionViewCell.cell(for: collectionView, at: indexPath) {
            cell.setup(video: videos[indexPath.row])
            return cell
        }
        
        if tag == 1 {
            if shopButton.isSelected, let cell = SellerShopCollectionViewCell.cell(for: collectionView, at: indexPath) {
                return cell
            }
            
            if danhmucButton.isSelected, let cell = DanhMucCollectionViewCell.cell(for: collectionView, at: indexPath) {
                return cell
            }
        }
        
        return .init()
    }
}
