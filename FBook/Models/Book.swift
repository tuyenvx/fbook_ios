//
//  Book.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct BookActivities {
    static let review = 0
    static let waiting = 1
    static let reading = 2
    static let returning = 3
    static let returned = 4
}

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

    struct ListRequests: Mappable {

        var waiting: [BookRequest]?
        var reading: [BookRequest]?
        var returning: [BookRequest]?
        var returned: [BookRequest]?
        var owners: [BookRequest]?
        var reviews: [Review]?

        init?(map: Map) {
            mapping(map: map)
        }

        init() {
            waiting = []
            reading = []
            returning = []
            returned = []
            owners = []
            reviews = []
        }

        mutating func mapping(map: Map) {
            waiting <- map["users_waiting"]
            reading <- map["users_reading"]
            returning <- map["users_returning"]
            returned <- map["users_returned"]
            owners <- map["owners"]
            reviews <- map["reviews_detail"]
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
    var requests: ListRequests?

    init() {}

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        detail = Detail(map: map)
        requests = ListRequests(map: map)
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
