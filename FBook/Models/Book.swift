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

    var id = 0
    var title = ""
    var description: String?
    var overview: String?
    var author: String?
    var publishDate: Date?
    var totalPage = 0
    var averageStar: Double = 0.0
    var totalView = 0
    var thumbnail: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        overview <- map["overview"]
        author <- map["author"]
        publishDate <- (map["publish_date"], CustomDateFormatTransform(formatString: kDateFormatYMD))
        totalPage <- map["total_page"]
        averageStar <- map["avg_star"]
        totalView <- map["count_view"]
        thumbnail <- map["image.mobile.thumbnail_path"]
    }

}

struct BookDetail: Mappable {

    var id = 0
    var title = ""
    var description: String?
    var overview: String?
    var author: String?
    var publishDate: Date?
    var totalPage = 0
    var averageStar: Double = 0.0
    var code = ""
    var totalView = 0
    var createdAt: Date?
    var updatedAt: Date?
    var deletedAt: Date?
    var media: [Media]?
    var reviews: [Review]?
    var usersWaiting: [User]?
    var usersReading: [User]?
    var usersReturning: [User]?
    var usersReturned: [User]?
    var category: Category?
    var office: Office?
    var owners: [User]?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        overview <- map["overview"]
        author <- map["author"]
        publishDate <- (map["publish_date"], CustomDateFormatTransform(formatString: kDateFormatYMD))
        totalPage <- map["total_page"]
        averageStar <- map["avg_star"]
        code <- map["code"]
        totalView <- map["count_view"]
        let dateTransform = CustomDateFormatTransform(formatString: kDateServerFormat)
        createdAt <- (map["created_at"], dateTransform)
        updatedAt <- (map["updated_at"], dateTransform)
        deletedAt <- (map["deleted_at"], dateTransform)
        media <- map["media"]
        reviews <- map["reviews_detail"]
        usersWaiting <- map["users_waiting"]
        usersReading <- map["users_reading"]
        usersReturning <- map["users_returning"]
        usersReturned <- map["users_returned"]
        category <- map["category"]
        office <- map["office"]
        owners <- map["owners"]
    }

}
