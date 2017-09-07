//
//  Media.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Media: Mappable {

    var id = 0
    var name: String?
    var path: String?
    var size: Double?
    var type = 1
    var thumbnailPath: String?
    var smallPath: String?
    var mediumPath: String?
    var largePath: String?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        path <- map["path"]
        size <- map["size"]
        type <- map["type"]
        thumbnailPath <- map["mobile.thumbnail_path"]
        smallPath <- map["mobile.small_path"]
        mediumPath <- map["mobile.medium_path"]
        largePath <- map["mobile.large_path"]
    }

}
