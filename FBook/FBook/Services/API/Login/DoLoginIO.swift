//
//  DoLoginIO.swift
//  FBook
//
//  Created by TuyenVX on 1/26/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import ObjectMapper

class DoLoginInput: APIInputBase {
    init(_ email: String,_ password: String) {
        let param = [
            "email": email,
            "password": password
        ]
        super.init(urlString: APIURL.login, parameters: param, requestType: .post)
    }
}

class DoLoginOutput: APIOutputBase {
    var fAuth: FAuth
    private override init() {
        fAuth = FAuth()
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        fAuth <- map["fauth"]
    }
}
