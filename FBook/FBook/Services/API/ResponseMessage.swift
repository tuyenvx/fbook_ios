//
//  ResponseMessage.swift
//  FBook
//
//  Created by admin on 5/24/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

struct ResponseMessage: Mappable {
    
    var code: Int
    var status: Bool
    var description: [String]
    
    init(code: Int, status: Bool, description: [String]) {
        self.code = code
        self.status = status
        self.description = description
    }
    
    init?(value: Any?) {
        if let message: ResponseMessage = ResponseMessage.object(from: value, key: "message") {
            self = message
        }
        else {
            return nil
        }
    }
    
    init?(map: Map) {
        self.init(code: 0, status: false, description: [])
    }
    
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        description <- map["description"]
    }
    
}

