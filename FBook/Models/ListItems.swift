//
//  ListItems.swift
//  FBook
//
//  Created by Huy Pham on 9/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct ListItems<T: Mappable>: Mappable {

    var total = 0
    var perPage = 0
    var currentPage = 0
    var nextPage: Int?
    var prevPage: Int?
    var data: [T] = []

    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        total <- map["total"]
        perPage <- map["per_page"]
        currentPage <- map["current_page"]
        nextPage <- map["next_page"]
        prevPage <- map["prev_page"]
        data <- map["data"]
    }

    mutating func append(_ listItem: ListItems<T>) {
        total = listItem.total
        perPage = listItem.perPage
        currentPage = listItem.currentPage
        nextPage = listItem.nextPage
        prevPage = listItem.prevPage
        data.append(contentsOf: listItem.data)
    }
}
