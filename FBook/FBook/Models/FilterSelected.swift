//
//  FilterSelected.swift
//  FBook
//
//  Created by admin on 6/2/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct FilterSelected {

    var offices = [Office]()
    var categories = [Category]()
    var sort : Sort?
    var order = Sort.sortDesc()
    
    func toFilterJson() -> [Any] {
        var filters = [Any]()
        if offices.count > 0 {
            filters.append(["office":offices.map{ $0.id }])
        }
        if categories.count > 0 {
            filters.append(["category":categories.map{ $0.id }])
        }
        return filters
    }
    
    func toSortJson() -> [String : Any] {
        var json = [String : Any]()
        if let sort = self.sort {
            json["key"] = sort.key
            json["order_by"] = order.key
        }
        return json
    }
}
