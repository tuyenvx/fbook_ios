//
//  FilterSortBookParams.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 10/5/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol Parameter {
    func toRequestJSON() -> [String: Any]
}

class FilterSortBookParams {

    var section = ""
    var sort = SortType.countView
    var categories: Category?
    var order: OrderBy = .desc
}

extension FilterSortBookParams: Parameter {

    func toRequestJSON() -> [String : Any] {
        let categriesId = [categories].flatMap { category -> String? in
            category?.id.description
        }
        return [
            "field": section,
            "filters": [["category": categriesId]],
            "sort": [
                "by": sort.rawValue,
                "order_by": order.rawValue
            ]
        ]
    }
}
