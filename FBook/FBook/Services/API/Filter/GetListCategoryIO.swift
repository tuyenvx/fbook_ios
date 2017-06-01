//
//  GetListCategoryIO.swift
//  FBook
//
//  Created by admin on 5/31/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class GetListCategoryInput: APIInputBase {
    
    init() {
        super.init(urlString: APIURL.categories,
                   parameters: nil,
                   requestType: .get)
    }
    
}

class GetListCategoryOutput: APIOutputBase {
    
    var categories: [Category]
    
    private override init() {
        categories = [Category]()
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        categories <- map["items"]
    }
}
