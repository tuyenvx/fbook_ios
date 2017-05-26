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
    
    init() {
        self.id = 0
        self.title = ""
        self.description = ""
        self.author = ""
        self.thumbnail = ""
        self.totalPage = 0
        self.totalView = 0
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        author <- map["author"]
        thumbnail <- map["image"]
        totalPage <- map["total_page"]
        totalView <- map["count_view"]
    }
}
