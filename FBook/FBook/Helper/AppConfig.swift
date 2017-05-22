//
//  AppConfig.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct AppConfig {

    
}

struct AppStrings {
    
    enum ProfileViewController: String {
        case myBookshare = "My Bookshare"
        case myWaitingBook = "My Waiting Book"
        case myReadingBook = "My Reading Book"
        case myReadBook = "My Read Book"
        case logout = "Log out"
    }
    
    enum AlertTitle: String {
        case title = "Alert"
        case error = "Error"
        case ok = "OK"
        case cancel = "Cancel"
    }
    
    enum AlertMessage: String {
        case  emailEmpty = "Email is empty"
        case  passEmpty = "Password is empty"
    }
}

struct AppColors {
    static let barTintColor = UIColor(netHex: 0x2e1126)
    static let tintColor = UIColor(netHex: 0xec5356)
    static let normalColor = UIColor.white
}

struct AppStoryboardSegue {
    static let identifierShowBookDetail = "showBookDetail"
}
