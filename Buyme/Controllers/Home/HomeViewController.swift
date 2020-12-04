//
//  HomeViewController.swift
//  Buyme
//
//  Created by Vinh LD on 9/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    var tabsView: UIView = .init()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var suggestingButton: UIButton!
    @IBOutlet weak var trendingButton: UIButton!
    
    private var tabs: [UIButton] { [followingButton, suggestingButton, trendingButton] }
    var products: [Product] = [
    .init(name: "18065816251741380939", video: "37322918484537068605", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "545063269024623444111", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "840845422251037567612", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "11872577020384669352", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "67482683536103484808", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "50896561048017056526", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "14733308977796058393", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "88933196843442697297", description: "18065816251741380939", cost: 1),
    .init(name: "18065816251741380939", video: "863994649416865203210", description: "18065816251741380939", cost: 1),
    .init(name: "91499447547729099884", video: "91499447547729099884", description: "91499447547729099884", cost: 1),
    .init(name: "91555661403983710301", video: "91555661403983710301", description: "91555661403983710301", cost: 1),
    .init(name: "18065816251741380939", video: "18065816251741380939", description: "18065816251741380939", cost: 1)
    ]
    
    @IBAction func changeTab(_ sender: UIButton) {
        for button in tabs {
            button.setTitleColor(.init(rgb: 0xFFFFFF, alpha: button.tag == sender.tag ? 1 : 0.8), for: .normal)
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
        } else {
            playCurrentCell()
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
    var shopViewController: ShopViewController = .init()

    override func viewDidLoad() {
        tabBarController?.tabBar.barTintColor = .black
        super.viewDidLoad()
        
        addChild()
        DispatchQueue.main.async {
            self.playCurrentCell()
        }
    }
    
    private func addChild() {
        addChild(shopViewController)
        shopViewController.didMove(toParent: self)
        self.contentView.addSubview(shopViewController.view)
        var frame = contentView.bounds
        frame.size.width /= 2
        frame.origin.x = frame.size.width
        shopViewController.view.frame = frame
    }
    
    private func addTabsView() {

    }
    
    override func initViews() {
        super.initViews()
        view.backgroundColor = .black
        
        PlayerCollectionViewCell.register(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.barTintColor = .white
        currentCell?.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.barTintColor = .black
        
        playCurrentCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.barTintColor = .black
    }
    
    @objc func touchUpInSide(_ sender: UIButton) {
        Mics.shared.log("Touch")
        sender.setTitle(DeviceUtils.shared.wifiIPAddress, for: .normal)
    }
    
    var currentCell: PlayerCollectionViewCell? {
        collectionView.visibleCells.first as? PlayerCollectionViewCell
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
        if let cell = cell as? PlayerCollectionViewCell {
            cell.pause()
        }
        playCurrentCell()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = PlayerCollectionViewCell.cell(for: collectionView, at: indexPath) {
            cell.product = products[indexPath.row]
            return cell
        }
        
        return .init()
    }
}
