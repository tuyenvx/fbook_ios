//
//  SectionBook.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct SectionBook: Mappable {

    var key = ""
    var title = ""
    var books: [Book]?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        key <- map["key"]
        title <- map["title"]
        books <- map["data"]
    }

}
