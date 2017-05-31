//
//  Book.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class Book: Mappable {

    var id : Int
    var title : String
    var description : String
    var author : String
    var thumbnail : String
    var totalPage : Int
    var totalView : Int
    var star : CGFloat
    var status : String
    var usersWaiting : [User]?
    var usersReading : [User]?
    var reviews : [Review]?
    
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.author = ""
        self.thumbnail = ""
        self.totalPage = 0
        self.totalView = 0
        self.star = 0.0
        self.status = ""
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        author <- map["author"]
        thumbnail <- map["image.thumb_path"]
        totalPage <- map["total_page"]
        totalView <- map["count_view"]
        star <- map["avg_star"]
        status <- map["status"]
        usersWaiting <- map["users_waiting_book"]
        usersReading <- map["user_reading_book"]
        reviews <- map["reviews_detail_book"]
    }
}
