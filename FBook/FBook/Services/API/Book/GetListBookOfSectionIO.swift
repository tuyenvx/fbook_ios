//
//  GetListBookOfSectionIO.swift
//  FBook
//
//  Created by admin on 5/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class GetListBookOfSectionInput: APIInputBase {
    
    init(key : String, page : Int) {
        let params : [String: Any] =  [
            "field": key,
            "page": page
        ]
        super.init(urlString: APIURL.getBooks,
                   parameters: params,
                   requestType: .get)
    }
    
}

class GetListBookOfSectionOutput: APIOutputBase {
    
    var pageList: PageList<Book>
    
    private override init() {
        pageList = PageList<Book>()
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        pageList <- map["item"]
    }
}
