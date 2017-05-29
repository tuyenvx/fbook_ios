//
//  PageList.swift
//  FBook
//
//  Created by admin on 5/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class PageList<Model: Mappable>: Mappable {
    
    var totalItems : Int
    var currentPage : Int
    var nextPage : Int?
    var prevPage : Int?
    var models : [Model]
    
    init() {
        totalItems = 0
        currentPage = 0
        models = []
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        totalItems <- map["total"]
        currentPage <- map["current_page"]
        nextPage <- map["next_page"]
        prevPage <- map["prev_page"]
        models <- map["data"]
    }
}
