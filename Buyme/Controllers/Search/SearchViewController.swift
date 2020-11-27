//
//  SearchViewController.swift
//  Buyme
//
//  Created by Vinh LD on 11/26/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {
    
    let kProductsTag: Int = 0
    let kCreatorsTag: Int = 1
    let kTopSearchTag: Int = 2
    let kCategoriesTag: Int = 3
    
    private var searchView: UIView!
    private var scrollContentView: UIView!
    
    private var productsView: UIView!
    private var boughtProductsLabel: Label!
    private var productsCollectionView: UICollectionView!
    
    private var creatorsView: UIView!
    private var boughtCreatorsLabel: Label!
    private var creatorsCollectionView: UICollectionView!
    
    private var topSearchView: UIView!
    private var categoriesView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initViews() {
        super.initViews()
        
        self.addSearchView()
        self.addProductsView()
        self.addCreatorsView()
        addTopSearchView()
        addCategories()
    }
    
    private func addListView(topConstrain: ConstraintItem, isLast: Bool = false, direction: UICollectionView.ScrollDirection = .horizontal, title: String, clTag: Int, nib: UINib, identifier: String) -> (UIView, Label, UICollectionView) {
        let contentView = UIView()
        self.scrollContentView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topConstrain).offset(5)
            make.right.left.equalToSuperview()
            if isLast {
                make.height.equalTo(500)
                make.bottom.equalToSuperview()
            } else {
                make.height.equalTo(210)
            }
        }
        
        let line = UIView()
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(5)
        }
        line.backgroundColor = .black// ColorUtils.shared.appColor
        
        let titleView = UIView()
        contentView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(49)
        }
        
        let stick = UIView()
        titleView.addSubview(stick)
        stick.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(5)
        }
        stick.backgroundColor = ColorUtils.shared.appColor
        
        let label = Label()
        titleView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalTo(stick)
            make.left.equalTo(stick.snp.right).offset(10)
        }
        label.autolocalizationKey = title
        label.font = Font.shared.medium?.withSize(13)
        
        let boughtNumberLabel = Label()
        titleView.addSubview(boughtNumberLabel)
        boughtNumberLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(titleView.snp.centerY)
            make.left.equalTo(label.snp.right).offset(5)
        }
        boughtNumberLabel.font = Font.shared.medium?.withSize(13)
        
        let boughtLabel = Label()
        titleView.addSubview(boughtLabel)
        boughtLabel.snp.makeConstraints { make in
            make.top.equalTo(boughtNumberLabel.snp.bottom).offset(3)
            make.right.equalToSuperview().offset(-10)
        }
        boughtLabel.font = Font.shared.regular?.withSize(10)
        boughtLabel.textColor = ColorUtils.shared.gray1
        boughtLabel.autolocalizationKey = isLast ? nil : "Sold"
        
        let layout = UICollectionViewFlowLayout()
        if isLast {
            let height: CGFloat = 120
            let maxWidth = self.view.bounds.size.width - 20
            let ns = (maxWidth / 100).rounded()
            let width: CGFloat = maxWidth / ns
            let size = CGSize(width: width - 5, height: height)
            layout.itemSize = size
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
        } else {
            layout.itemSize = CGSize(width: 100, height: 150)
        }
        layout.scrollDirection = direction
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = clTag
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            if isLast {
                make.right.equalToSuperview().offset(-10)
            } else {
                make.right.equalToSuperview()
            }
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        collectionView.backgroundColor = .clear
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return (contentView, boughtNumberLabel, collectionView)
    }
    
    private func addProductsView() {
        let information = addListView(topConstrain: scrollContentView.snp.top, title: "Products for you", clTag: kProductsTag, nib: ProductsForYouCollectionViewCell.nib, identifier: ProductsForYouCollectionViewCell.className)
        productsView = information.0
        boughtProductsLabel = information.1
        productsCollectionView = information.2
        boughtProductsLabel.text = "4,57 M"
    }
    
    private func addCreatorsView() {
        let information = addListView(topConstrain: productsView.snp.bottom, title: "Shop", clTag: kCreatorsTag, nib: ShopForYouCollectionViewCell.nib, identifier: ShopForYouCollectionViewCell.className)
        creatorsView = information.0
        boughtCreatorsLabel = information.1
        creatorsCollectionView = information.2
        boughtCreatorsLabel.text = "7,54 M"
    }
    
    private func addTopSearchView() {
        let information = addListView(topConstrain: creatorsView.snp.bottom, title: "Top Search", clTag: kTopSearchTag, nib: TopSearchCollectionViewCell.nib, identifier: TopSearchCollectionViewCell.className)
        topSearchView = information.0
        information.1.text = "696.9 K"
    }
    
    private func addCategories() {
        let information = addListView(topConstrain: topSearchView.snp.bottom, isLast: true, direction: .vertical, title: "Categories", clTag: kCategoriesTag, nib: TopSearchCollectionViewCell.nib, identifier: TopSearchCollectionViewCell.className)
    }
    
    @objc func search(_ sender: UIButton) {
        Mics.shared.log("Search")
    }
    
    private func addSearchView() {
        searchView = UIView()
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        searchView.backgroundColor = ColorUtils.shared.gray3
        searchView.cornerRadius = 2
        
        let image = UIImageView(image: UIImage(named: "SearchBlack"))
        searchView.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        let label = Label()
        searchView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(image.snp.right).offset(10)
        }
        label.autolocalizationKey = "Search"
        label.textColor = ColorUtils.shared.gray1
        label.font = Font.shared.regular
        
        let button = UIButton()
        searchView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        button.addTarget(self, action: #selector(search(_:)), for: .touchUpInside)
        
        let contentView = UIView()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.right.bottom.left.equalTo(self.view.safeAreaLayoutGuide)
        }
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        scrollContentView = .init()
        scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
            make.width.equalTo(self.view.snp.width)
        }
    }

}
