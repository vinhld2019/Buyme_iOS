//
//  ApiUtils.swift
//  
//
//  Created by Vinh LD on 2/10/20.
//

import UIKit
import Alamofire
import ObjectMapper

typealias ApiCompletionHandler<T> = (_ completion: Bool, _ success: Bool, _ response: T?, _ error: NSError?) -> Void
typealias ApiCompletion = () -> Void

class ApiUtils: NSObject {

    static let shared = ApiUtils()
    
    var sessionManager: SessionManager!
    var sizeOfPage: Int = 100
    let timeoutInterval: TimeInterval = 60
    var isAccessDenied: Bool = false
    var domain: String { Config.shared.apiURL }
    
    func initialization() {
        // trust Certificate for call https
        sessionManager = SessionManager(
        configuration: .default,
        serverTrustPolicyManager: ServerTrustPolicyManager(policies: [domain: ServerTrustPolicy.disableEvaluation]))

        sessionManager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?

            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust, let trust = challenge.protectionSpace.serverTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential(trust: trust)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = self.sessionManager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)

                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }

            return (disposition, credential)
        }
        // completion handle
    }
    
    func invalidateAndCancel() {
        self.sessionManager.session.invalidateAndCancel()
        self.initialization()
    }

    func alert(_ message: String?, title: String = "Error", completion: @escaping ApiCompletion) {
        AppUtils.shared.showAlert(tag: TagUtils.shared.newTag, title: title, content: message)
        completion()
    }
    
    func alert(_ message: String?, title: String = "Error") {
        self.alert(message, title: title) {
            nothingHandle(text: message)
        }
    }
    
    func showLoading(tag: Int = 0) {
        DispatchQueue.main.async {
            AppUtils.shared.window?.showLoading(tag: tag)
        }
    }
    
    func hideLoading(tag: Int = 0) {
        DispatchQueue.main.async {
            AppUtils.shared.window?.hideLoading(tag: tag)
        }
    }
    
    func clearCookie() {
        let cstorage = HTTPCookieStorage.shared
        if let url = URL(string: domain),
            let cookies = cstorage.cookies(for: url) {
            for cookie in cookies {
                cstorage.deleteCookie(cookie)
            }
        }
    }
    
    func statusValidation(response: HTTPURLResponse?) -> Bool {
        guard let status = response?.statusCode else {
            return false
        }
        
        switch status {
        case 200:
            return true
            
        case 401, 403:
            let message = "Access Denied"
            if !self.isAccessDenied {
                self.alert(message) {
                    self.invalidateAndCancel()
                    AppUtils.shared.logout()
                }
            }
            return false
            
        default:
            if let httpResponse = VLDHttpUrlResponse(rawValue: status) {
                self.alert(httpResponse.description, title: httpResponse.message)
            }
            return false
        }
    }
    
    func call(_ url: String,
              body: Any? = nil,
              parameter: [String: Any]? = nil,
              httpMethod: HTTPMethod = .get,
              header: HTTPHeaders? = Header.shared.defaultH,
              loading: Bool = true,
              checkStatus: Bool = true,
              completionHandler: @escaping ApiCompletionHandler<DataResponse<Any>>) {
        var newUrl = url

        if let params = parameter {
            for (key, value) in params {
                let sub = (key == params.first?.key) ? "?" : "&"
                newUrl += "\(sub)\(key)=\(value)"
            }
        }
        self.clearCookie()
        do {
            var request = try URLRequest(url: URL(string: newUrl)!, method: httpMethod, headers: header)
            if let body = body, let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
                request.httpBody = httpBody
            }
            request.timeoutInterval = timeoutInterval
            let tag = TagUtils.shared.newTag
            if loading {
                self.showLoading(tag: tag)
            }
            
            sessionManager.request(request).validate().responseJSON { response in
                self.hideLoading(tag: tag)
                if !checkStatus {
                    completionHandler(true, response.result.isSuccess, response, nil)
                    return
                }
                
                if self.statusValidation(response: response.response) {
                    completionHandler(true, response.result.isSuccess, response, nil)
                } else if response.response?.statusCode == nil, let error = response.error as NSError? {
                    self.alert(error.localizedDescription)
                }
            }
            
        } catch {
            completionHandler(false, false, nil, error as NSError)
        }
    }
    
    // base
}

class Header: NSObject {
    static let shared = Header()
    
    var defaultH: HTTPHeaders {
        ["Content-type": "application/json"]
    }
}
