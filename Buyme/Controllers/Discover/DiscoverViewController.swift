//
//  DiscoverViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var categoriesView: HorizontalMenuView!
    @IBOutlet weak var pagerView: PagerView!
    @IBOutlet weak var danhchobanCollectionView: UICollectionView!
    @IBOutlet weak var toptimkiemCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.categoriesView.reloadDatas()
        }
        
        pagerView.register(BannerCollectionViewCell.nib, forCellWithReuseIdentifier: BannerCollectionViewCell.className)
        pagerView.dataSource = self
        pagerView.delegate = self
        
        DiscoverSuggestCollectionViewCell.register(danhchobanCollectionView)
        SellerShopCollectionViewCell.register(toptimkiemCollectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async { [unowned self] in
            if !isSet {
                isSet = true
                pagerView.startControl()
                searchView.selection = {
                    let vc = SearchViewController()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    var isSet: Bool = false

}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = collectionView.tag
        if tag == 0 {
            return CGSize(width: 80, height: 80)
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

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.tag == 0 ? 10 : 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        if tag == 0, let cell = DiscoverSuggestCollectionViewCell.cell(for: collectionView, at: indexPath) {
            return cell
        }
        
        if tag == 1, let cell = SellerShopCollectionViewCell.cell(for: collectionView, at: indexPath) {
            return cell
        }
        return .init()
    }
}

extension DiscoverViewController: PagerViewDataSource {
    func pagerView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func pagerView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = BannerCollectionViewCell.cell(for: collectionView, at: indexPath) {
            return cell
        }
        
        return .init()
    }
}

extension DiscoverViewController: PagerViewDelegate {
    func pagerView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(SellerViewController(), animated: true)
    }
}
