//
//  Office.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct Office: Mappable {

    var id = 0
    var name = ""
    var area = ""
    var description = ""

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        area <- map["area"]
        description <- map["description"]
    }

}
