//
//  Review.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Review: Mappable {

    var id = 0
    var content = ""
    var star = 0
    var createdAt: Date?
    var user: User?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        star <- map["star"]
        createdAt <- (map["created_at"], CustomDateFormatTransform(formatString: kDateServerFormat))
        user <- map["user"]
    }

}
