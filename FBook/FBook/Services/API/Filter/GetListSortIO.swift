//
//  GetListSortIO.swift
//  FBook
//
//  Created by admin on 6/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class GetListSortInput: APIInputBase {
    
    init() {
        super.init(urlString: APIURL.sort,
                   parameters: nil,
                   requestType: .get)
    }
    
}

class GetListSortOutput: APIOutputBase {
    
    var sorts: [Sort]
    
    private override init() {
        sorts = [Sort]()
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        sorts <- map["items"]
    }
}
