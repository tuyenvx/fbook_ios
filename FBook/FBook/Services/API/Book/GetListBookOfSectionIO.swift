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
    
    init(filter : FilterSelected, page : Int) {
        let urlString = APIURL.booksCondition + "?field=\(filter.sort?.key ?? "")&page=\(page)"
        let params : [String: Any] =  [
            "filters" : filter.toFilterJson(),
            "sort" : filter.toSortJson()
        ]
        super.init(urlString: urlString,
                   parameters: params,
                   requestType: .post)
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
