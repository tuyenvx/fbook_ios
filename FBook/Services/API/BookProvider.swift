//
//  BookProvider.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import ObjectMapper

final class BookProvider: BaseProvider {

    typealias BookDetailSignal = SignalProducer<BookDetail, ErrorResponse>
    typealias BookListSignal = SignalProducer<ListItems<Book>, ErrorResponse>

    static func getBookDetail(bookId: Int) -> BookDetailSignal {
        return requestJSON(api: .getBookDetail(bookId)).flatMap(.merge) { object -> BookDetailSignal in
            if let value = object?.value as? [String: Any], let item = value[kItem] as? [String: Any],
                    let bookDetail = BookDetail(JSON: item) {
                return BookDetailSignal(value: bookDetail)
            }
            return BookDetailSignal(error: .errorJsonFormat)
        }
    }

    static func searchBook(officeId: Int?, page: Int, params: SearchBookParams) -> BookListSignal {
        return requestJSON(api: .searchBook(officeId, page, params)).flatMap(.merge, { object -> BookListSignal in
            if let value = object?.value as? [String: Any], let items = value[kItems] as? [String: Any],
                    let listBooks = ListItems<Book>(JSON: items) {
                return BookListSignal(value: listBooks)
            }
            return BookListSignal(error: .errorJsonFormat)
        })
    }
}
