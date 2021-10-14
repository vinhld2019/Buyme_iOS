//
//  ProductViewController.swift
//  Buyme
//
//  Created by Vinh LD on 12/28/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import BMPlayer

class ProductViewController: BaseViewController {
    
    @IBOutlet weak var player: Player!
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var listViewHeigt: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var shareButton: PlayerButton!
    @IBOutlet weak var commentButton: PlayerButton!
    @IBOutlet weak var likeButton: PlayerButton!
    @IBOutlet weak var cartButton: PlayerButton!
    
    @IBAction func buy(_ sender: UIButton) {
        self.present(AddCartViewController(), animated: true)
    }
    
    @IBAction func touchPlayer(_ sender: UIButton) {
        if player.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func play() {
        playButtonView.isHidden = true
        listViewHeigt.constant = 0
        player.play()
    }
    
    func pause() {
        playButtonView.isHidden = false
        listViewHeigt.constant = 140
        player.pause()
        collectionView.reloadData()
    }
    
    lazy var videos: [Video] = {
        let vs = randomVideos
        vs.first?.image = "JW"
        return vs
    }()
    var currentIndex: Int = 0
    var percent: CGFloat = 0
    
    var backAction: (() -> Void)?
    
    private func selectVideo(_ row: Int, isPlay: Bool = true) {
        percent = 0
       
        if let link = videos[row].link, let path = Bundle.main.path(forResource: link, ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            player.setVideo(resource: .init(url: url))
            isPlay ? play() : pause()
        }
        for index in 0...videos.count - 1 {
            videos[index].isSelected = index == row
        }
        collectionView.reloadData()
    }
    
    override func back(_ sender: UIButton) {
        if let action = backAction {
            action()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.delegate = self
        ProductListCollectionViewCell.register(collectionView)
        selectVideo(0, isPlay: false)
        
        shareButton.delegate = self
        commentButton.delegate = self
        likeButton.delegate = self
        cartButton.delegate = self
    }
    
}

extension ProductViewController: BMPlayerDelegate {
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        if state == .playedToTheEnd {
            pause()
        }
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        self.percent = CGFloat(currentTime) * 100 / CGFloat(totalTime)
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 130, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == currentIndex {
            play()
        } else {
            currentIndex = row
            selectVideo(row)
        }
    }
}

extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = ProductListCollectionViewCell.cell(for: collectionView, at: indexPath) {
            cell.setup(video: videos[indexPath.row], percent: self.percent)
            return cell
        }
        
        return .init()
    }
}

extension ProductViewController: PlayerButtonDelegate {
    func playerButton(touchAt button: PlayerButton) {
        let tag = button.tag
        switch tag {
        case 0:
            let vc = UIActivityViewController(activityItems: ["https://www.facebook.com/vnvinhld"], applicationActivities: nil)
            AppUtils.shared.present(vc, animated: true)
            
        case 1:
            let vc = CommentViewController()
            vc.modalPresentationStyle = .overFullScreen
            navigation?.present(vc, animated: true, completion: nil)
            
        case 2:
            let isSelected = !button.isSelected
            button.isSelected = isSelected
            button.imageView.tintColor = isSelected ? ColorUtils.shared.red : .white
            
        case 3:
            AppUtils.shared.present(AddCartViewController(), animated: true)
            
        default:
            break
        }
    }
}
