//
//  FAuth.swift
//  FBook
//
//  Created by TuyenVX on 1/26/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class FAuth: Mappable {
    var access_token: String
    var refresh_token: String
    var  exprires_in: Int
    
    init() {
        access_token = ""
        refresh_token = ""
        exprires_in = 0
    }
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        access_token <- map["access_token"]
        refresh_token <- map["refresh_token"]
        exprires_in <- map["expires_in"]
    }
}
class Token {
    static var access_token: String? {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.string(forKey: "access_token")
        }
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: "access_token")
        }
    }
    static var refresh_token: String? {
        get {
            let userDefaults = UserDefaults.standard
            return userDefaults.string(forKey: "refresh_token")
        }
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(newValue, forKey: "refresh_token")
        }
    }
    class func initWith(_ fAuth: FAuth) {
        access_token = fAuth.access_token
        refresh_token = fAuth.refresh_token
        synchronize()
    }
    class func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
