//
//  AddToCartView.swift
//  Buyme
//
//  Created by Vinh LD on 12/1/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class AddToCartView: FromNibBaseView {
    
    let kPhanLoaiTag: Int = 0
    let kMauTag: Int = 1
    let kSizeTag: Int = 2
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var phanloaiCollectionView: UICollectionView!
    @IBOutlet weak var mauCollectionView: UICollectionView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    var phanloai: [(String, Bool)] = [("Nam", false), ("Nữ", false)]
    var mau: [(String, Bool)] = [("Đen", false), ("Lam", false), ("Đỏ", false), ("Trắng", false)]
    var size: [(String, Bool)] = [("38", false), ("39", false), ("40", false), ("41", false)]
    
    @IBAction func close(_ sender: UIButton) {
        sender.backgroundColor = .clear
        self.close()
    }
    
    func close() {
        Self.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = self.frame.size.height
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        self.close()
    }
    
    override func initViews() {
        super.initViews()
        
        CartSizeCollectionViewCell.register(phanloaiCollectionView)
        phanloaiCollectionView.delegate = self
        phanloaiCollectionView.dataSource = self
        CartSizeCollectionViewCell.register(mauCollectionView)
        mauCollectionView.delegate = self
        mauCollectionView.dataSource = self
        CartSizeCollectionViewCell.register(sizeCollectionView)
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
    }
}

extension AddToCartView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.size.width / 4 - 5, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension AddToCartView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case kPhanLoaiTag:
            return phanloai.count
            
        case kMauTag:
            return mau.count
            
        case kSizeTag:
            return size.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        if let cell = CartSizeCollectionViewCell.cell(for: collectionView, at: indexPath) {
            var text: String?
            var selected: Bool = false
            switch collectionView.tag {
            case kPhanLoaiTag:
                text = phanloai[row].0
                selected = phanloai[row].1
                
            case kMauTag:
                text = mau[row].0
                selected = mau[row].1
                
            case kSizeTag:
                text = size[row].0
                selected = size[row].1
                
            default:
                break
            }
            cell.label.text = text
            cell.view.backgroundColor = selected ? .gray : .white
            cell.collectionView = collectionView
            cell.delegate = self
            return cell
        }
        
        return .init()
    }
}

extension AddToCartView: CartSizeCollectionViewCellDelegate {
    func cartSizeCollectionViewCell(touchUpInsideAt cell: CartSizeCollectionViewCell, view: UICollectionView) {
        if let indexPath = view.indexPath(for: cell) {
            switch view.tag {
            case kPhanLoaiTag:
                for index in 0...phanloai.count - 1 {
                    phanloai[index].1 = index == indexPath.row
                }
                
            case kMauTag:
                for index in 0...mau.count - 1 {
                    mau[index].1 = index == indexPath.row
                }
                
            case kSizeTag:
                for index in 0...size.count - 1 {
                    size[index].1 = index == indexPath.row
                }
                
            default:
                break
            }
            view.reloadData()
        }
    }
}

extension UIView {
    func addToCartShow() {
        let view = AddToCartView()
        addSubview(view)
        
        var frame = self.bounds
        frame.origin.y = self.bounds.size.height
        view.frame = frame
        Self.animate(withDuration: 0.3, animations: {
            view.frame.origin.y = 0
        }, completion: { _ in
            view.frame.origin.y = 0
            view.closeButton.backgroundColor = .init(rgb: 0x000000, alpha: 0.4)
        })
    }
}
