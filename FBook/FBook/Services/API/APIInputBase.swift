//
//  APIInputBase.swift
//  FBook
//
//  Created by admin on 5/24/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Alamofire

class APIInputBase {
    let headers = [
        "Content-Type":"application/json; charset=utf-8",
        "Accept":"application/json"
    ]
    let urlString: String
    let requestType: HTTPMethod
    var encoding: ParameterEncoding
    let parameters: [String: Any]?
    let isTokenRequired: Bool
    
    init(urlString: String, parameters: [String: Any]?, requestType: HTTPMethod, isTokenRequired: Bool = false) {
        self.urlString = urlString
        self.parameters = parameters
        self.requestType = requestType
        self.encoding = requestType == .get ? URLEncoding.default : JSONEncoding.default
        self.isTokenRequired = isTokenRequired
    }
    
    func printInputParametters() {
        do {
            if let params = self.parameters {
                let data = try JSONSerialization.data(withJSONObject: params,
                                                      options: .prettyPrinted)
                let jsonData = try JSONSerialization.jsonObject(with: data,
                                                                options: .allowFragments)
                print(jsonData)
            }
        } catch {
            print(error)
        }
    }
}
