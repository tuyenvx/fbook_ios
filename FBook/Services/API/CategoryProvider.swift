//
//  CategoryProvider.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import ObjectMapper

final class CategoryProvider: BaseProvider {

    typealias CategorySignal = SignalProducer<[Category], ErrorResponse>
    typealias BookListSignal = SignalProducer<ListItemsCategory, ErrorResponse>

    static func getBooks(inCategory categoryId: Int) -> BookListSignal {
        return requestJSON(api: .getBooksInCategory(categoryId)).flatMap(.merge, { object -> BookListSignal in
            if let value = object?.value as? [String: Any], let json = value[kItem] as? [String: Any],
                    let listBooks = Mapper<ListItemsCategory>().map(JSON: json) {
                return BookListSignal(value: listBooks)
            }
            return BookListSignal(error: .errorJsonFormat)
        })
    }

    static func getCategories() -> CategorySignal {
        return requestJSON(api: .getCategories).flatMap(.merge, { object -> CategorySignal in
            if let value = object?.value as? [String: Any], let items = value[kItems] as? [[String: Any]] {
                let categories = Mapper<Category>().mapArray(JSONArray: items)
                return CategorySignal(value: categories)
            }
            return CategorySignal(error: .errorJsonFormat)
        })
    }

}
