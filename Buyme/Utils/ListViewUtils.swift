//
//  ListViewUtils.swift
//  EBanking
//
//  Created by Vinh LD on 3/17/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

protocol ListViewDatasource {
    var isLoading: Bool {get}
    var hasMoreDatas: Bool {get}
    var numberOfItems: Int {get}
    var canLoadMoreDatas: Bool {get}
    func loadMoreDatas()
    func refreshData()
}
