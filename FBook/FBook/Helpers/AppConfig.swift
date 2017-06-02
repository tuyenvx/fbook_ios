//
//  AppConfig.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct AppConfig {

    static var filter = FilterSelected()
}

struct AppStrings {
    
    enum Title: String {
        case filter = "Filter"
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
    
    enum ProfileViewController: String {
        case myBookshare = "My Bookshare"
        case myWaitingBook = "My Waiting Book"
        case myReadingBook = "My Reading Book"
        case myReadBook = "My Read Book"
        case logout = "Log out"
    }
    
    enum BookDetailViewController: String {
        case totalView = "Views: "
        case totalPage = "Pages: "
    }
    
    enum FilterViewController: String {
        case office = "Office"
        case category = "Category"
        case sort = "Sort By"
    }
}

struct AppColors {
    static let barTintColor = UIColor(netHex: 0x2e1126)
    static let tintColor = UIColor(netHex: 0xec5356)
    static let normalColor = UIColor.white
}

struct AppStoryboards {
    static let storyboardLogin = "Login"
    static let segueIdentifierShowBookDetail = "showBookDetail"
    static let segueIdentifierShowListBook = "showListBook"
    static let segueIdentifierShowFilter = "showFilter"
    static let segueIdentifierShowChooseFilter = "showChooseFilter"
    static let segueIdentifierShowChooseSort = "showChooseSort"
}
