//
//  FollowInfo.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

struct FollowInfo: Mappable {
    var followers = [User]()
    var following = [User]()
    var isFollow: Bool?
    var countFollowed = 0
    var countFollowing = 0

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        followers <- map["followedBy"]
        following <- map["following"]
        isFollow <- map["isFollow"]
        countFollowed <- map["countFollowed"]
        countFollowing <- map["countFollowing"]
    }
}
