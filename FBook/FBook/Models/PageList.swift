//
//  PageList.swift
//  FBook
//
//  Created by admin on 5/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class PageList<Model: NSObject>: NSObject {
    
    var currentPage : Int
    var totalPage : Int
    var models : [Model]
    
    override init() {
        currentPage = 0
        totalPage = 0
        models = []
    }
}
