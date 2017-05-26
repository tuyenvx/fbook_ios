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
    
    var currentPage : Int
    var totalPage : Int
    var models : [Model]
    
    init() {
        currentPage = 0
        totalPage = 0
        models = []
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
}
