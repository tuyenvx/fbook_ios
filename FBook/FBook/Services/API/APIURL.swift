//
//  APIURL.swift
//  FBook
//
//  Created by admin on 5/24/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct APIURL {
    
    static let base = "http://api-book.framgia.vn/api/v0"
    
    // BOOK
    static let homePage = base + "/home/filters"
    static let books = base + "/books"
    
    // FILTER
    static let booksCondition = base + "/books/filters"
    static let categories = base + "/categories"
    static let office = base + "/offices"
    static let sort = base + "/books/condition-sort"
    
    // USER
    static let login = base + "/login"
    static let register = base + "/register"
}

