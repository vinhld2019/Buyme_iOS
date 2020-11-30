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
//        followingView.setVideo(link: "https://v9-vn.tiktokcdn.com/574348b2bf83393a0ce3d73db33a52a5/5fc56e0a/video/tos/alisg/tos-alisg-pve-0037c001/52c28b666a454b73a9fd4dcd2ac26092/")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        tabBarController?.tabBar.barTintColor = .white
//        followingView.player.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarController?.tabBar.barTintColor = .black
//        followingView.player.play()
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
        print(indexPath.row)
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            print(indexPath?.row)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = PlayerCollectionViewCell.cell(for: collectionView, at: indexPath) {
            return cell
        }
        
        return .init()
    }
}
