//
//  GetDetailBookIO.swift
//  FBook
//
//  Created by admin on 5/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class GetBookDetailInput: APIInputBase {
    
    init(bookID : Int) {
        let urlString = APIURL.books + "/\(bookID)"
        super.init(urlString: urlString,
                   parameters: nil,
                   requestType: .get)
    }
}

class GetBookDetailOutput: APIOutputBase {
    
    var book: Book
    
    private override init() {
        book = Book()
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        book <- map["item"]
    }
}

