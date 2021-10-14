//
//  DanhMucViewController.swift
//  Buyme
//
//  Created by Vinh LD on 27/09/2021.
//  Copyright © 2021 Vinh LD. All rights reserved.
//

import UIKit

class DanhMucViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        SellerShopCollectionViewCell.register(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension DanhMucViewController: UICollectionViewDelegateFlowLayout {
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

extension DanhMucViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = SellerShopCollectionViewCell.cell(for: collectionView, at: indexPath) {
            return cell
        }
        
        return .init()
    }
}
