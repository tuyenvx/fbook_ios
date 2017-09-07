//
//  ObjectResponse.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

struct ObjectResponse {
    var value: Any?
    var message: MessageResponse?
}

struct ErrorResponse: Error {
    var value: Any?
    var errorMessage: MessageResponse?

    static let errorJsonFormat = ErrorResponse(value: nil, errorMessage: MessageResponse(status: false, code: 601,
        description: ["Error json format"]))
}

struct MessageResponse {

    var status = true
    var code = 0
    var description: [String] = []

    var message: String? {
        return description.first
    }

}
