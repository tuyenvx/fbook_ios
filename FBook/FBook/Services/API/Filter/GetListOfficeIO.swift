//
//  GetListOfficeIO.swift
//  FBook
//
//  Created by admin on 5/31/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class GetListOfficeInput: APIInputBase {
    
    init() {
        super.init(urlString: APIURL.office,
                   parameters: nil,
                   requestType: .get)
    }
    
}

class GetListOfficeOutput: APIOutputBase {
    
    var offices: [Office]
    
    private override init() {
        offices = [Office]()
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        offices <- map["items"]
    }
}

