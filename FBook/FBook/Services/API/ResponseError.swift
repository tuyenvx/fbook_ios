//
//  ResponseError.swift
//  FBook
//
//  Created by admin on 5/24/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum ResponseError: Error {
    
    case noStatusCode
    case invalidData
    case validate(statusCode: Int)
    case responseMessage(message: ResponseMessage?)
    
    var description: String {
        switch self {
        case .validate(let code):
            if let responseCode = ResponseStatusCode(rawValue: code) {
                return responseCode.toString()
            }
            return "unknown \(code)"
        case .responseMessage(let message):
            if let message = message {
                return message.description.joined(separator: " ")
            }
            return "responseMessage unknown"
        default: return String(describing: self)
        }
    }
}

enum ResponseStatusCode: Int {
    
    case success            = 200
    case notModified        = 304
    case badRequest         = 400
    case unauthorized       = 401
    case accessDenied       = 403
    case notFound           = 404
    case methodNotAllowed   = 405
    case validatorError     = 422
    case serverError        = 500
    case badGateway         = 502
    case serviceUnavailable = 503
    case gatewayTimeout     = 504
    
    func toString() -> String {
        var description: String
        switch self {
        case .success:
            description = "success"
        case .notModified:
            description = "not modified"
        case .badRequest:
            description = "invalid request"
        case .unauthorized:
            description = "unauthorized"
        case .accessDenied:
            description = "access denied"
        case .notFound:
            description = "not found"
        case .methodNotAllowed:
            description = "method not allowed"
        case .validatorError:
            description = "validator error"
        case .serverError:
            description = "server error"
        case .badGateway:
            description = "bad gateway"
        case .serviceUnavailable:
            description = "service unavailable"
        case .gatewayTimeout:
            description = "gatewaytTimeout"
        }
        return "\(self.rawValue) - " + description
    }
}

