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

    fileprivate static var _currentId: Int?
    static var currentId: Int? {
        get {
            if _currentId != nil {
                return _currentId
            } else if let savedId = userDefaults.value(forKey: kCurrentOfficeIdKey) as? Int {
                _currentId = savedId
            }
            return _currentId
        }
        set {
            _currentId = newValue
            userDefaults.set(newValue, forKey: kCurrentOfficeIdKey)
        }
    }

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
