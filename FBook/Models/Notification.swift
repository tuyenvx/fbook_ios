//
//  Notification.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Notification: Mappable {
    var currentPage: Int?
    var data = [NotificationDetail]()
    var fromPage: Int?
    var lastPage: Int?
    var nextPageUrl = ""
    var path = ""
    var perPage: Int?
    var prevPageUrl = ""
    var toPage: Int?
    var total: Int?

    init() {}

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        currentPage <- map["current_page"]
        data <- map["data"]
        fromPage <- map["from"]
        lastPage <- map["last_page"]
        nextPageUrl <- map["next_page_rl"]
        path <- map["path"]
        perPage <- map["per_page"]
        prevPageUrl <- map["prev_page_url"]
        toPage <- map["to"]
        total <- map["total"]
    }
}

struct NotificationDetail: Mappable {
    var id = 0
    var userSend: User?
    var userReceive: User?
    var target: Book?
    var viewed = 0
    var type = ""
    var createdAt: Date?
    var updatedAt: Date?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        userSend <- map["user_send"]
        userReceive <- map["user_receive"]
        target <- map["book"]
        viewed <- map["viewed"]
        type <- map["type"]
        let dateTransform = CustomDateFormatTransform(formatString: kDateServerFormat)
        createdAt <- (map["created_at"], dateTransform)
        updatedAt <- (map["updated_at"], dateTransform)
    }
}
