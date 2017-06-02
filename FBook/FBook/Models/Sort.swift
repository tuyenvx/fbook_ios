//
//  Sort.swift
//  FBook
//
//  Created by admin on 6/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

struct Sort: Mappable {
    
    var title : String
    var key : String
    
    init() {
        title = ""
        key = ""
    }
    
    init(title : String, key : String) {
        self.title = title
        self.key = key
    }
    
    static func sortDesc() -> Sort {
        return Sort(title: "Desc", key: "desc")
    }
    
    static func sortAsc() -> Sort {
        return Sort(title: "Asc", key: "asc")
    }
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        key <- map["key"]
    }
}

