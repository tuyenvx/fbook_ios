//
//  SectionBook.swift
//  FBook
//
//  Created by admin on 5/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class SectionBook: Mappable {
    
    var sort : Sort
    var books : [Book]?
    
    init() {
        sort = Sort()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        sort.title <- map["title"]
        sort.key <- map["key"]
        books <- map["data"]
    }
}
