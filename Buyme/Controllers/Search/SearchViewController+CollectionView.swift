//
//  SearchViewController+CollectionView.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

extension SearchViewController: UICollectionViewDelegate {
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        let row = indexPath.row
        
        switch tag {
        case kProductsTag:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsForYouCollectionViewCell.className, for: indexPath) as? ProductsForYouCollectionViewCell {
                return cell
            }
            
        case kCreatorsTag:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopForYouCollectionViewCell.className, for: indexPath) as? ShopForYouCollectionViewCell {
                return cell
            }
            
        case kTopSearchTag:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSearchCollectionViewCell.className, for: indexPath) as? TopSearchCollectionViewCell {
                return cell
            }
                
        case kCategoriesTag:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSearchCollectionViewCell.className, for: indexPath) as? TopSearchCollectionViewCell {
                cell.index = row
                return cell
            }
            
        default:
            break
        }
        
        return .init()
    }
}
