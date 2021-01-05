//
//  SellerViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/21/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class SellerViewController: BaseViewController {
    
    @IBOutlet weak var vuaxemCollectionView: UICollectionView!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    
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
    
    var backAction: (() -> Void)?
    var videos: [Video] = [.init(link: "download", image: "image", text: "@victoriavaldez046"),
                           .init(link: "download1", image: "image1", text: "@sol_leon21"),
                           .init(link: "download2", image: "image2", text: "@carmenaurora01"),
                           .init(link: "download3", image: "image3", text: "@kryramirez")]

    override func viewDidLoad() {
        super.viewDidLoad()

        ProductListCollectionViewCell.register(vuaxemCollectionView)
        SellerShopCollectionViewCell.register(shopCollectionView)
    }

}

extension SellerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = collectionView.tag
        if tag == 0 {
            return .init(width: 130, height: 120)
        }
        
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

extension SellerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.tag == 0 ? videos.count : 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        if tag == 0, let cell = ProductListCollectionViewCell.cell(for: collectionView, at: indexPath) {
            cell.setup(video: videos[indexPath.row])
            return cell
        }
        
        if tag == 1, let cell = SellerShopCollectionViewCell.cell(for: collectionView, at: indexPath) {
            return cell
        }
        
        return .init()
    }
}
