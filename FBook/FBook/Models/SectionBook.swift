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
    var title : String
    var key : String
    var books : [Book]?
    
    init() {
        title = ""
        key = ""
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        key <- map["key"]
        books <- map["data"]
    }
}
