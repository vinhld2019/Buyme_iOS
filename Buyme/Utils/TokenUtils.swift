//
//  TokenUtils.swift
//  Buyme
//
//  Created by Vinh LD on 3/16/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation
import JWTDecode

class TokenUtils {

    static let shared = TokenUtils()

    init() {
        self.initialization()
    }

    func initialization() {
        let token = ""
        if !token.isEmpty {
            do {
                self.jwt = try decode(jwt: token)
            } catch {
                nothingHandle(error: error)
            }
        } else {
            self.jwt = nil
        }
    }

    var jwt: JWT?

    var issuer: String? {
        return jwt?.issuer
    }
    var subject: String {
        return jwt?.subject ?? "00000000000000000000000000000000"
    }
    var audience: [String] {
        return jwt?.audience ?? []
    }
    var aud: String? {
        return audience.first
    }
    var expiresAt: Date? {
        return jwt?.expiresAt
    }
    var exp: Int64? {
        return expiresAt?.timeStamp
    }

    var tokenHasExpire: Bool {
        if let expireTime = exp {
            return Date.currentTimeInSeconds >= expireTime
        }
        return true
    }
}
