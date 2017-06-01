//
//  Category.swift
//  FBook
//
//  Created by admin on 5/31/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

struct Category: Mappable {
    
    var id : Int
    var name : String
    
    init() {
        id = 0
        name = ""
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
