//
//  Error+Extensions.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

extension Error {

    var message: String {
        if let error = self as? ErrorResponse {
            return error.errorMessage?.message ?? ""
        }
        return self.localizedDescription
    }

}
