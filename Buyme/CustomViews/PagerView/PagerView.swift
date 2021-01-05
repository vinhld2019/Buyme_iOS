//
//  PagerView.swift
//  Buyme
//
//  Created by Vinh LD on 12/29/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

protocol PagerViewDelegate: class {
    func pagerView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func pagerView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

extension PagerViewDelegate {
    func pagerView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
    func pagerView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

protocol PagerViewDataSource: class {
    func pagerView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func pagerView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class PagerView: FromNibBaseView {
    
    weak var delegate: PagerViewDelegate?
    weak var dataSource: PagerViewDataSource?
    
    @IBOutlet weak var pager: UICollectionView!
    @IBOutlet weak var control: UICollectionView!
    
    private var totalPage: Int = 0
    var currentPageIndex: Int {
        if let cell = currentPage, let indexPath = pager.indexPath(for: cell) {
            let row = indexPath.row
            return (row + totalPage - 1) % totalPage
        }
        return 0
    }
    var currentPage: UICollectionViewCell? { pager.visibleCells.first }
    
    override func initialization() {
        super.initialization()
        
        PageControlCollectionViewCell.register(control)
    }
    
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        DispatchQueue.main.async {
            self.pager.register(nib, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func refreshControl() {
        if let cell = currentPage, let index = pager.indexPath(for: cell)?.row {
            if index == 0 {
                pager.scrollToItem(at: .init(row: totalPage, section: 0), at: .left, animated: false)
            }
            
            if index == totalPage + 1 {
                pager.scrollToItem(at: .init(row: 1, section: 0), at: .left, animated: false)
            }
            DispatchQueue.main.async {
                self.control.reloadData()
            }
        }
    }
    
    func startControl() {
        pager.scrollToItem(at: .init(row: 1, section: 0), at: .left, animated: false)
        DispatchQueue.main.async {
            self.control.reloadData()
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            self.nextPage()
        }
    }
    
    func nextPage() {
        pager.scrollToItem(at: .init(row: currentPageIndex + 2, section: 0), at: .left, animated: true)
        DispatchQueue.main.async {
            self.control.reloadData()
        }
    }
}

extension PagerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = collectionView.tag
        
        if tag == 0 {
            return delegate?.pagerView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? collectionView.bounds.size
        }
        
        if tag == 1 {
            return .init(width: 20, height: 20)
        }
        
        return UICollectionViewFlowLayout.automaticSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let tag = collectionView.tag
        
        if tag == 1 {
            let totalCellWidth = 20 * totalPage

            let leftInset = (collectionView.bounds.size.width - CGFloat(totalCellWidth)) / 2
            let rightInset = leftInset

            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = collectionView.tag
        if tag == 0 {
            delegate?.pagerView(collectionView, didSelectItemAt: indexPath)
            return
        }
    }
}

extension PagerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        if let number = dataSource?.pagerView(collectionView, numberOfItemsInSection: section) {
            totalPage = number
            return tag == 0 ? totalPage + 2 : number
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        let row = indexPath.row
        if tag == 0, let cell = dataSource?.pagerView(collectionView, cellForItemAt: indexPath) {
            return cell
        }
        
        if tag == 1, let cell = PageControlCollectionViewCell.cell(for: collectionView, at: indexPath) {
            cell.setup(isSelected: row == currentPageIndex)
            return cell
        }
        
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let tag = collectionView.tag
        if tag == 0 {
            refreshControl()
        }
    }
}
