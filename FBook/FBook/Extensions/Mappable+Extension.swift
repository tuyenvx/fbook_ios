//
//  Mappable+Model.swift
//  FBook
//
//  Created by admin on 5/24/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

extension Mappable {
    static func object<T: Mappable>(from data: Any?, key: String? = nil) -> T? {
        guard data != nil else {
            return nil
        }
        let data = data as AnyObject
        var jsonDictionary: [String: Any]?
        if let key = key,
            let json = data[key] as? [String: Any]
        {
            jsonDictionary = json
        }
        else if let json = data as? [String: Any] {
            jsonDictionary = json
        }
        if let json = jsonDictionary {
            return T(JSON: json)
        }
        return nil
    }
    
    static func array<T: Mappable>(from data: Any?, key: String? = nil) -> [T]? {
        guard data != nil else {
            return nil
        }
        let data = data as AnyObject
        var jsonArrayDictionary: [[String: Any]]?
        if let key = key, let jsonArray = data[key] as? [[String: Any]] {
            jsonArrayDictionary = jsonArray
        }
        else if let jsonArray = data as? [[String: Any]] {
            jsonArrayDictionary = jsonArray
        }
        var objectArray = [T]()
        if let jsonArray = jsonArrayDictionary {
            for json in jsonArray {
                if let t = T(JSON: json) {
                    objectArray.append(t)
                }
            }
            return objectArray
        }
        return nil
    }
}
