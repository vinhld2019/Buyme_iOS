//
//  HomeViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/20/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabBarView: TabBarView!
    
    @IBOutlet weak var headTabView: UIView!
    @IBOutlet weak var suggestingButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var trendingButton: UIButton!
    @IBOutlet weak var suggestingCollectionView: UICollectionView!
    @IBOutlet weak var followingCollectionView: UICollectionView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    @IBOutlet weak var fabView: UIView!
    @IBOutlet weak var fabButton: UIButton!
    var fabPanGesture: UIPanGestureRecognizer!
    
    private func addFabPanGesture() {
        for view in fabView.subviews where view is UIImageView {
            (view as? UIImageView)?.image = UIImage(named: "ProductCartBuy")?.withRenderingMode(.alwaysTemplate)
            view.tintColor = .red
            break
        }
        
        fabPanGesture = .init(target: self, action: #selector(fabDragged(_:)))
        fabView.isUserInteractionEnabled = true
        fabView.addGestureRecognizer(fabPanGesture)
    }
    
    @objc private func fabDragged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: fabView.superview!)
        fabView.center = CGPoint(x: fabView.center.x + translation.x, y: fabView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: fabView.superview!)
    }
    
    lazy var links: [String] = { getLinks }()
    var followingList:[String] = []
    var trendingList:[String] = []
    
    @IBAction func fab(_ sender: UIButton) {
        playerActionIsHidden = !playerActionIsHidden
        currentCell?.updateDisplayActions()
        headTabView.isHidden = playerActionIsHidden
        
        fabView.alpha = 1
        blurFabWorkingTag += 1
        blurFab(blurFabWorkingTag)
    }
    
    private var blurFabWorkingTag = 0
    private func blurFab(_ tag: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if tag >= self.blurFabWorkingTag {
                UIView.animate(withDuration: 0.3) {
                    self.fabView.alpha = 0.3
                }
            }
        }
    }
    
    @IBAction func changeContent(_ sender: UIButton) {
        let buttons: [UIButton] = [suggestingButton, followingButton, trendingButton]
        let collectionViews: [UICollectionView] = [suggestingCollectionView, followingCollectionView, trendingCollectionView]
        let tag = sender.tag
        currentCell?.pause()
        for index in 0...buttons.count-1 {
            let button = buttons[index]
            let collectionView = collectionViews[index]
            let isSelected = tag == button.tag
            button.isSelected = isSelected
            collectionView.isHidden = !isSelected
            if isSelected {
                self.collectionView = collectionView
                playCurrentCell()
            }
        }
    }
    
    @IBAction func panDirection(_ pan: UIPanGestureRecognizer) {
        let locationPoint = pan.location(in: self.contentView)
        let x = contentView.frame.origin.x
        let width = contentView.frame.size.width
        
        switch pan.state {
        case .began:
            startX = locationPoint.x
            
        case .changed:
            let xChanged = locationPoint.x - startX
            var newX = x + xChanged
            if newX > 0 { newX = 0 }
            if newX < -width / 2 { newX = -width / 2 }
            contentView.frame.origin.x = newX
            
        case .cancelled:
            childHandler()
            
        case .failed:
            childHandler()
            
        case .ended:
            if (childShowing && x > -width / 2)
                || (!childShowing && x < 0) {
                childShowing = !childShowing
                childHandler()
            }
            
        default:
            break
        }
    }
    
    private func childHandler() {
        if childShowing {
            currentCell?.pause()
            if let vc = parent as? TabBarViewController {
                vc.isTabBarEnable = false
            }
            fabView.isHidden = true
        } else {
            playCurrentCell()
            if let vc = parent as? TabBarViewController {
                vc.isTabBarEnable = true
            }
            tabBarView.isHidden = false
            fabView.isHidden = false
        }
        let x = childShowing ? -self.contentView.frame.size.width / 2 : 0
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.x = x
        }, completion: { _ in
            self.contentView.frame.origin.x = x
        })
    }
    
    var childShowing: Bool = false
    var startX: CGFloat = 0
    var panDirection: Int = 0
    var productViewController: SellerViewController!
    
    private func addProduct() {
        productViewController = .init()
        productViewController.backAction = {
            self.childShowing = !self.childShowing
            self.childHandler()
        }
        addChild(productViewController)
        productViewController.didMove(toParent: self)
        contentView.addSubview(productViewController.view)
        let size = contentView.bounds.size
        let width = size.width / 2
        productViewController.view.frame = CGRect(x: width, y: 0, width: width, height: size.height)
    }
    
    func viewProduct() {
        childShowing = true
        childHandler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.addProduct()
        }
        
        HomeCollectionViewCell.register(suggestingCollectionView)
        HomeCollectionViewCell.register(followingCollectionView)
        HomeCollectionViewCell.register(trendingCollectionView)
        
        followingList = links.shuffled()
        trendingList = links.shuffled()
        
        collectionView = suggestingCollectionView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.playCurrentCell()
        }
        
        blurFab(0)
        addFabPanGesture()
        
        headTabView.isHidden = playerActionIsHidden
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentCell?.pause()
    }
    
    var collectionView: UICollectionView?
    var currentCell: HomeCollectionViewCell? {
        collectionView?.visibleCells.first as? HomeCollectionViewCell
    }
    
    func playCurrentCell() {
        currentCell?.play()
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? HomeCollectionViewCell {
            cell.pause()
        }
        playCurrentCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? HomeCollectionViewCell {
            cell.updateDisplayActions()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = HomeCollectionViewCell.cell(for: collectionView, at: indexPath) {
            if(collectionView == followingCollectionView){
                cell.link = followingList[indexPath.row]
            }else if(collectionView == trendingCollectionView){
                cell.link = trendingList[indexPath.row]
            }else{
                 cell.link = links[indexPath.row]
            }
            cell.updateDisplayActions()
            return cell
        }
        return .init()
    }
}
