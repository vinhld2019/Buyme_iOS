//
//  UPUpdateRequest.swift
//  Retail
//
//  Created by Vinh LD on 4/6/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class UPUpdateRequest: RequestDatasource {
    var module: ModuleApi { .updateUserProfile }

    var profile: UserProfileResult?
    var language: ServerLanguage?

    init(profile: UserProfileResult, language: ServerLanguage) {
        self.profile = profile
        self.language = language
    }

    var body: [[String: Any]] {
        [
            FieldRequest.shared.d00.str.withValue(value: profile?.email ?? "").request,
            FieldRequest.shared.d01.str.withValue(value: profile?.userID ?? "").request,
            FieldRequest.shared.d03.str.withValue(value: profile?.username ?? "").request,
            FieldRequest.shared.d04.str.withValue(value: profile?.branchName ?? "").request,
            FieldRequest.shared.d05.str.withValue(value: language?.rawValue ?? "").request,
            FieldRequest.shared.d06.str.withValue(value: profile?.mobileNo ?? "").request
        ]
    }
}

extension ApiUtils {
}
