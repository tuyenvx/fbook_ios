//
//  User.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {

    var id = 0
    var name = ""
    var email = ""
    var phone = ""
    var code = ""
    var position = ""
    var role = ""
    var officeId: Int?
    var createdAt: Date?
    var updatedAt: Date?
    var deletedAt: Date?
    var avatar = ""
    var favoriteCategories = [Category]()

    fileprivate static var _currentUser: User?
    static var currentUser: User? {
        get {
            if _currentUser != nil {
                return _currentUser
            } else if let userJSONString = userDefaults.value(forKey: kCurrentUserKey) as? String {
                _currentUser = User(JSONString: userJSONString)
            }
            return _currentUser
        }
        set {
            _currentUser = newValue
            userDefaults.set(newValue?.toJSONString(), forKey: kCurrentUserKey)
        }
    }

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        code <- map["code"]
        position <- map["position"]
        role <- map["role"]
        avatar <- map["avatar"]
        officeId <- map["office_id"]
        let dateTransform = CustomDateFormatTransform(formatString: kDateServerFormat)
        createdAt <- (map["created_at"], dateTransform)
        updatedAt <- (map["updated_at"], dateTransform)
        deletedAt <- (map["deleted_at"], dateTransform)
        avatar <- map["avatar"]
        favoriteCategories <- map["categories"]
    }

}
