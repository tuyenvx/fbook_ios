//
//  SearchBookParams.swift
//  FBook
//
//  Created by Huy Pham on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class SearchBookParams {

    var keyword = ""
    var type: SearchType = .title
    var categories: [Category] = []
    var sort: SortType = .countView
    var order: OrderBy = .desc

    func toRequestJSON() -> [String: Any] {
        return [
            "search": [
                "keyword": keyword,
                "field": type.toString()
            ],
            "conditions": [
                "category": categories.map { $0.id }
            ],
            "sort": [
                "field": sort.rawValue,
                "order_by": order.rawValue
            ]
        ]
    }
}

enum SortType: String {

    case countView = "count_view"
    case avgStar = "avg_star"
    case createdAt = "created_at"
    case title = "title"
    case publishDate = "publish_date"
    case author = "author"

    func getTitle() -> String {
        switch self {
        case .countView: return "Count view"
        case .avgStar: return "Average star"
        case .createdAt: return "Create date"
        case .title: return "Title"
        case .publishDate: return "Publish date"
        case .author: return "Author"
        }
    }
}

enum OrderBy: String {

    case desc
    case asc
}
