//
//  Book.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Book: Mappable {

    struct Detail: Mappable {

        var code = ""
        var media: [Media]?
        var reviews: [Review]?
        var category: Category?
        var office: Office?
        var createdAt: Date?
        var updatedAt: Date?
        var deletedAt: Date?

        init?(map: Map) {
            mapping(map: map)
        }

        mutating func mapping(map: Map) {
            code <- map["code"]
            media <- map["media"]
            reviews <- map["reviews_detail"]
            category <- map["category"]
            office <- map["office"]
            let dateTransform = CustomDateFormatTransform(formatString: kDateServerFormat)
            createdAt <- (map["created_at"], dateTransform)
            updatedAt <- (map["updated_at"], dateTransform)
            deletedAt <- (map["deleted_at"], dateTransform)
        }
    }

    struct ListUsers: Mappable {

        var waiting: [User]?
        var reading: [User]?
        var returning: [User]?
        var returned: [User]?
        var owners: [User]?

        init?(map: Map) {
            mapping(map: map)
        }

        mutating func mapping(map: Map) {
            waiting <- map["users_waiting"]
            reading <- map["users_reading"]
            returning <- map["users_returning"]
            returned <- map["users_returned"]
            owners <- map["owners"]
        }
    }

    var id = 0
    var title = ""
    var description: String?
    var overview: String?
    var author: String?
    var publishDate: Date?
    var totalPage = 0
    var totalView = 0
    var averageStar: Double = 0.0
    var thumbnail: String?

    var detail: Detail?
    var users: ListUsers?

    init() {}

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        detail = Detail(map: map)
        users = ListUsers(map: map)
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        overview <- map["overview"]
        author <- map["author"]
        publishDate <- (map["publish_date"], CustomDateFormatTransform(formatString: kDateFormatYMD))
        totalPage <- map["total_page"]
        totalView <- map["count_view"]
        averageStar <- map["avg_star"]
        thumbnail <- map["image.mobile.thumbnail_path"]
    }

}
