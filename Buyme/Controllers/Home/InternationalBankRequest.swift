//
//  InternationalBankRequest.swift
//  Retail
//
//  Created by Vinh LD on 11/25/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import ObjectMapper

class InternationalBankRequest: SearchRequest {
    
    init(code: String?, name: String?) {
        self.code = code
        self.name = name
    }
    
    var code: String?
    var name: String?
    var key: String = ""
    
    var body: [String: Any] {
        [kConditions: [],
         kPageSize: pageSize,
         kSearchResultKey: key,
         kValues: [ValueRequest.shared.d01.str.with(value: code).request,
                   ValueRequest.shared.d27.str.with(value: name).request]]
    }
    
    var items: [InternationalBank] = []
    var hasMoreDatas: Bool { totalRows >= Int64(page) * Int64(pageSize) }
    var totalRows: Int64 = 0
    var page: Int = 1
    
    func search(completion: @escaping ApiCompletion) {
        api.searchExecuteSearch(information: (.m03073, .mmn, nil), body: body, class: InternationalBank.self) { _, _, response, _ in
            if let res = response {
                self.items = res.container
                self.key = res.searchResultKey
                self.totalRows = res.totalRow ?? 0
            }
            completion()
        }
    }
    
    func loadMore(completion: @escaping ApiCompletion) {
        if !hasMoreDatas {
            completion()
            return
        }
        
        let nextPage = page + 1
        api.bufferFetchPage(information: (.m03073, nextPage), body: body, class: InternationalBank.self) { _, _, response, _ in
            if let res = response {
                let container = res.container
                if container.count > 0 {
                    self.items.append(contentsOf: container)
                    self.page = nextPage
                }
            }
            completion()
        }
    }
}
