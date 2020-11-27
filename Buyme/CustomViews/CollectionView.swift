//
//  CollectionView.swift
//  Corporate
//
//  Created by Vinh LD on 7/8/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class CollectionViewDatas {
    
    var collectionView: UICollectionView?
    var key: CollectionViewKey?
    
    static var shared: CollectionViewDatas {
        CollectionViewDatas()
    }
    
    func with(_ collectionView: UICollectionView) -> Self {
        self.collectionView = collectionView
        return self
    }
    
    func with(key: CollectionViewKey) -> Self {
        self.key = key
        return self
    }
    
    var size: CGSize {
        guard let view = self.collectionView,
            let key = self.key else {
                return CGSize()
        }
        let size = view.frame.size
        let multiples: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
        var itemMaxInWidth = multiples
        var itemHeight: CGFloat = 0
        switch key {
        case .home:
            itemMaxInWidth *= 3
            itemHeight = 100
            
        case .others:
            itemMaxInWidth *= 3
            itemHeight = 100
        }
        
        return createSize(width: size.width, max: itemMaxInWidth, height: itemHeight)
    }
    
    func createSize(width: CGFloat, max: CGFloat, height: CGFloat) -> CGSize {
        CGSize(width: (width - 5 * (max - 1)) / max, height: height)
    }
}

enum CollectionViewKey: String {
    case home
    case others
}
