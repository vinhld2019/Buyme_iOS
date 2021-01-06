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
    
    var links: [String] = [
         "2264578168350",
         "2264577653585",
         "2264577606506",
         "2264577571678",
         "2264577330807",
         "2264577256479",
         "2264577165089",
         "2264577104820",
         "2264577033489",
         "2264576977681",
         "2264576907126",
         "2264576783852",
         "2264576623838",
         "2264576556512",
         "2264576467889",
         "2264576314124",
         "2264576144144",
         "2264576051482",
         "2264575959630",
         "2264575815117",
         "2264575683254",
         "2264575589166",
         "2264575527896",
         "2264575468450",
         "2264575346626",
         "2264575149765",
         "2264575020073",
         "2264574877709",
         "2264574824653",
         "2264574791783",
         "2264574732567",
         "2264574629465",
         "2264574497478",
         "2264574313708",
         "2264573973112",
         "2264573684985",
         "2264573605690",
         "2264573544517",
         "2264573414423",
         "2264573369693",
         "2264573335078",
         "2264573238751",
         "2264573168685",
         "2264572959531",
         "2264572899987",
         "2264572683817",
         "2264572642621",
         "2264572359115",
         "2264572091747",
         "2264571852333",
         "52447502271100128260",
         "804507111835993576861",
         "836387204350753913162",
         "399628389825030905163",
         "780730425841364500464",
         "465717446220362513665",
         "125031647035304628366",
         "294501242154012804967",
         "77168146100102885768",
         "249189126873640619569",
         "813227380460278052070",
         "31425019493017703271",
         "88417596391045463772",
         "33739304879452671773",
         "623492046878464101974",
         "557730235596964779775",
         "496991303013374896551",
         "188096544186541333752",
         "135864306680236995853",
         "379542672640545230054",
         "804153058512165488155",
         "105211142210770024556",
         "436199957408625077157",
         "605512630895471937858",
         "657703138996839326459",
         "52447502271100128276",
         "804507111835993576877",
         "836387204350753913178",
         "399628389825030905179",
         "780730425841364500480",
         "465717446220362513681",
         "125031647035304628382",
         "294501242154012804983",
         "249189126873640619585",
         "813227380460278052086",
         "31425019493017703287",
         "88417596391045463788",
         "623492046878464101990",
         "557730235596964779791"
     ]
    var followingList:[String] = []
    var trendingList:[String] = []
    
    
    
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
        
        followingList = links.shuffled()
        trendingList = links.shuffled()
        
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
            return cell
        }
        return .init()
    }
}







