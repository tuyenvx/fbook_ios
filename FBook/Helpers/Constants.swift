//
//  Constants.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

let application = UIApplication.shared
let appDelegate = application.delegate as? AppDelegate
let userDefaults = UserDefaults.standard

let kDateServerFormat = "yyyy-MM-dd HH:mm:ss"
let kDateFormatYMD = "yyyy-MM-dd"

// Constants for UserDefaults
let kAccessTokenKey = "com.framgia.fbook.access_token"
let kRefreshTokenKey = "com.framgia.fbook.refresh_token"

let kAccessToken = "access_token"
let kRefreshToken = "refresh_token"
let kFauth = "fauth"
let kItem = "item"
let kItems = "items"

let kMessage = "message"
let kStatus = "status"
let kCode = "code"
let kDescription = "description"

// Constants for UIAlertController
let kOKString = "OK"
let kCancelString = "Cancel"

// Constants for alert message
let kErrorSystem = "Server error"
let kErrorNetwork = "Can't connect to server"
