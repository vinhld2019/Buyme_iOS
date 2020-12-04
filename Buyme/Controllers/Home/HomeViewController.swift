//
//  HomeViewController.swift
//  Buyme
//
//  Created by Vinh LD on 9/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
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

    override func viewDidLoad() {
        tabBarController?.tabBar.barTintColor = .black
        super.viewDidLoad()
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
        if let cell = collectionView.visibleCells.first as? PlayerCollectionViewCell {
            cell.pause()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.barTintColor = .black
        if let cell = collectionView.visibleCells.first as? PlayerCollectionViewCell {
            cell.play()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.barTintColor = .black
    }
    
    @objc func touchUpInSide(_ sender: UIButton) {
        Mics.shared.log("Touch")
        sender.setTitle(DeviceUtils.shared.wifiIPAddress, for: .normal)
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
        if let cell = collectionView.visibleCells.first as? PlayerCollectionViewCell {
            cell.play()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = PlayerCollectionViewCell.cell(for: collectionView, at: indexPath) {
            cell.product = products[indexPath.row]
            if indexPath.row == 0 {
                cell.playView.play()
            }
            return cell
        }
        
        return .init()
    }
}
