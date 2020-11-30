//
//  SearchWithCategoriesViewController+CollectionView.swift
//  Buyme
//
//  Created by Vinh LD on 11/30/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

extension SearchWithCategoriesViewController: UICollectionViewDelegateFlowLayout {
    
}

extension SearchWithCategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        switch tag {
        case kCategoriesTag:
            return category?.children.count ?? 0
            
        case kProductsTag:
            return products.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        switch tag {
        case kCategoriesTag:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSearchCollectionViewCell.className, for: indexPath) as? TopSearchCollectionViewCell {
                
                return cell
            }
            
        case kProductsTag:
            break
            
        default:
            break
        }
        
        return .init()
    }
}
