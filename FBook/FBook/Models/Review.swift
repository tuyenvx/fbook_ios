//
//  Review.swift
//  FBook
//
//  Created by admin on 5/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

struct Review : Mappable {
    
    var id : Int
    var content : String
    var star : Int
    var user : User
    
    init() {
        id = 0
        content = ""
        star = 0
        user = User()
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        star <- map["star"]
        user <- map["user"]
    }
}
