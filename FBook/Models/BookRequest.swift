//
//  BookRequest.swift
//  FBook
//
//  Created by Huy Pham on 9/21/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct BookRequest: Mappable {

    struct Pivot: Mappable {

        var bookId = 0
        var userId = 0
        var status = 0
        var type: String?
        var createdAt: Date?
        var updatedAt: Date?

        init?(map: Map) {
            mapping(map: map)
        }

        mutating func mapping(map: Map) {
            bookId <- map["book_id"]
            userId <- map["user_id"]
            status <- map["status"]
            type <- map["type"]
            let dateTransform = CustomDateFormatTransform(formatString: kDateServerFormat)
            createdAt <- (map["created_at"], dateTransform)
            updatedAt <- (map["updated_at"], dateTransform)
        }
    }

    var id = 0
    var name = ""
    var avatar: String?
    var position = ""
    var email = ""
    var pivot: Pivot?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        position <- map["position"]
        email <- map["email"]
        pivot <- map["pivot"]
    }
}
