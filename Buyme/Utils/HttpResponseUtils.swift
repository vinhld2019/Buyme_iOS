//
//  HttpResponseUtils.swift
//  Corporate
//
//  Created by Vinh LD on 8/12/20.
//  Copyright © 2020 Vinh LD. All rights reserved.
//

import Foundation

enum VLDHttpUrlResponse: Int {
    case cont = 100 // Continue
    case switchingProtocols = 101
    case checkpoint = 103
    case ok = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case switchProxy = 306
    case temporaryRedirect = 307
    case resumeIncomplete = 308
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestUriTooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case httpVersionNotSupported = 505
    case networkAuthenticationRequired = 511
    
    var info: (String, String) {
        switch self {
        case .cont:
            return ("Continue", "The server has received the request headers, and the client should proceed to send the request body")
        case .switchingProtocols:
            return ("Switching Protocols", "The requester has asked the server to switch protocols")
        case .checkpoint:
            return ("Checkpoint", "Used in the resumable requests proposal to resume aborted PUT or POST requests")
        case .ok:
            return ("OK", "The request is OK (this is the standard response for successful HTTP requests)")
        case .created:
            return ("Created", "The request has been fulfilled, and a new resource is created ")
        case .accepted:
            return ("Accepted", "The request has been accepted for processing, but the processing has not been completed")
        case .nonAuthoritativeInformation:
            return ("Non-Authoritative Information", "The request has been successfully processed, but is returning information that may be from another source")
        case .noContent:
            return ("No Content", "The request has been successfully processed, but is not returning any content")
        case .resetContent:
            return ("Reset Content", "The request has been successfully processed, but is not returning any content, and requires that the requester reset the document view")
        case .partialContent:
            return ("Partial Content", "The server is delivering only part of the resource due to a range header sent by the client")
        case .multipleChoices:
            return ("Multiple Choices", "A link list. The user can select a link and go to that location. Maximum five addresses  ")
        case .movedPermanently:
            return ("Moved Permanently", "The requested page has moved to a new URL ")
        case .found:
            return ("Found", "The requested page has moved temporarily to a new URL ")
        case .seeOther:
            return ("See Other", "The requested page can be found under a different URL")
        case .notModified:
            return ("Not Modified", "Indicates the requested page has not been modified since last requested")
        case .switchProxy:
            return ("Switch Proxy", "No longer used")
        case .temporaryRedirect:
            return ("Temporary Redirect", "The requested page has moved temporarily to a new URL")
        case .resumeIncomplete:
            return ("Resume Incomplete", "Used in the resumable requests proposal to resume aborted PUT or POST requests")
        case .badRequest:
            return ("Bad Request", "The request cannot be fulfilled due to bad syntax")
        case .unauthorized:
            return ("Unauthorized", "The request was a legal request, but the server is refusing to respond to it. For use when authentication is possible but has failed or not yet been provided")
        case .paymentRequired:
            return ("Payment Required", "Reserved for future use")
        case .forbidden:
            return ("Forbidden", "The request was a legal request, but the server is refusing to respond to it")
        case .notFound:
            return ("Not Found", "The requested page could not be found but may be available again in the future")
        case .methodNotAllowed:
            return ("Method Not Allowed", "A request was made of a page using a request method not supported by that page")
        case .notAcceptable:
            return ("Not Acceptable", "The server can only generate a response that is not accepted by the client")
        case .proxyAuthenticationRequired:
            return ("Proxy Authentication Required", "The client must first authenticate itself with the proxy")
        case .requestTimeout:
            return ("Request Timeout", "The server timed out waiting for the request")
        case .conflict:
            return ("Conflict", "The request could not be completed because of a conflict in the request")
        case .gone:
            return ("Gone", "The requested page is no longer available")
        case .lengthRequired:
            return ("Length Required", "The 'Content-Length' is not defined. The server will not accept the request without it ")
        case .preconditionFailed:
            return ("Precondition Failed", "The precondition given in the request evaluated to false by the server")
        case .requestEntityTooLarge:
            return ("Request Entity Too Large", "The server will not accept the request, because the request entity is too large")
        case .requestUriTooLong:
            return ("Request-URI Too Long", "The server will not accept the request, because the URL is too long. Occurs when you convert a POST request to a GET request with a long query information ")
        case .unsupportedMediaType:
            return ("Unsupported Media Type", "The server will not accept the request, because the media type is not supported ")
        case .requestedRangeNotSatisfiable:
            return ("Requested Range Not Satisfiable", "The client has asked for a portion of the file, but the server cannot supply that portion")
        case .expectationFailed:
            return ("Expectation Failed", "The server cannot meet the requirements of the Expect request-header field")
        case .internalServerError:
            return ("Internal Server Error", "A generic error message, given when no more specific message is suitable")
        case .notImplemented:
            return ("Not Implemented", "The server either does not recognize the request method, or it lacks the ability to fulfill the request")
        case .badGateway:
            return ("Bad Gateway", "The server was acting as a gateway or proxy and received an invalid response from the upstream server")
        case .serviceUnavailable:
            return ("Service Unavailable", "The server is currently unavailable (overloaded or down)")
        case .gatewayTimeout:
            return ("Gateway Timeout", "The server was acting as a gateway or proxy and did not receive a timely response from the upstream server")
        case .httpVersionNotSupported:
            return ("HTTP Version Not Supported", "The server does not support the HTTP protocol version used in the request")
        case .networkAuthenticationRequired:
            return ("Network Authentication Required", "The client needs to authenticate to gain network access")
        }
    }
    
    var message: String {
        info.0
    }
    
    var description: String {
        info.1
    }
}
