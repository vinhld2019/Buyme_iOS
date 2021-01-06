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
    
    @IBOutlet weak var suggestingButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var trendingButton: UIButton!
    @IBOutlet weak var suggestingCollectionView: UICollectionView!
    @IBOutlet weak var followingCollectionView: UICollectionView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
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
            //            productViewController.play()
        } else {
            playCurrentCell()
            if let vc = parent as? TabBarViewController {
                vc.isTabBarEnable = true
            }
            tabBarView.isHidden = false
            //            productViewController.pause()
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
        
        collectionView = suggestingCollectionView
        
        DispatchQueue.main.async {
            print(self.view.frame.size.width)
            print(self.contentView.frame.size.width)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentCell?.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !view.isHidden {
            playCurrentCell()
        }
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
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = HomeCollectionViewCell.cell(for: collectionView, at: indexPath) {
            var links: [String] = [
                "37322918484537068605",
                "37322918484537068605",
                "77168146100102885784","557730235596964779791",
                "465717446220362513681",
                "780730425841364500480",
                "836387204350753913178","249189126873640619585",
                "249189126873640619585",
                "840845422251037567612",
                "804507111835993576877",
            ]
            
            if(collectionView == trendingCollectionView){
                links = [
                    "52447502271100128276",
                    "11872577020384669352",
                    "50896561048017056526",
                    "125031647035304628382",
                    "88417596391045463788",
                    "14733308977796058393",
                    "623492046878464101990",
                    "88933196843442697297",
                    "33739304879452671789",
                    "863994649416865203210",
                    "31425019493017703287",
                    "91499447547729099884",
                    "91555661403983710301",
                ]
            }
            if(collectionView == followingCollectionView ){
                links = [
                    "840845422251037567612",
                    "804507111835993576877",
                    "836387204350753913178",
                    "11872577020384669352",
                    "31425019493017703287",
                    "780730425841364500480",
                    "465717446220362513681",
                    "125031647035304628382",
                    "77168146100102885784",
                    "623492046878464101990",
                    "31425019493017703287",
                    "91499447547729099884",
                    "840845422251037567612",
                ]
            }
            
            cell.link = links[indexPath.row]
            return cell
        }
        return .init()
    }
}
