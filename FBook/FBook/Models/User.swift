//
//  User.swift
//  FBook
//
//  Created by admin on 5/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

struct User : Mappable {
    
    var id : Int
    var name : String
    var email : String
    var avatar : String
    var token : String
    
    init() {
        id = 0
        name = ""
        email = ""
        avatar = ""
        token = ""
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        avatar <- map["avatar"]
        token <- map["access_token"]
    }
}
