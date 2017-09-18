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

    typealias BookDetailSignal = SignalProducer<Book, ErrorResponse>
    typealias BookListSignal = SignalProducer<ListItems<Book>, ErrorResponse>

    static func getBookDetail(bookId: Int) -> BookDetailSignal {
        return requestJSON(api: .getBookDetail(bookId)).flatMap(.merge, mapBook)
    }

    static func searchBook(officeId: Int?, page: Int, params: SearchBookParams) -> BookListSignal {
        return requestJSON(api: .searchBook(officeId, page, params)).flatMap(.merge, mapBookList)
    }

    static func getBooks(inSection section: SectionBook, page: Int, officeId: Int?) -> BookListSignal {
        return requestJSON(api: .getBookInSection(officeId, page, section)).flatMap(.merge, mapBookList)
    }

    static func bookingBook(params: BookingBookParams) -> BooleanSignal {
        return requestJSON(api: .bookingBook(params)).flatMap(.merge, mapBoolean)
    }

    fileprivate static let mapBookList = { (object: ObjectResponse?) -> BookListSignal in
        if let value = object?.value as? [String: Any], let items = value[kItems] as? [String: Any],
            let listBooks = ListItems<Book>(JSON: items) {
            return BookListSignal(value: listBooks)
        }
        return BookListSignal(error: .errorJsonFormat)
    }

    fileprivate static let mapBook = { (object: ObjectResponse?) -> BookDetailSignal in
        if let value = object?.value as? [String: Any], let item = value[kItem] as? [String: Any],
            let book = Book(JSON: item) {
            return BookDetailSignal(value: book)
        }
        return BookDetailSignal(error: .errorJsonFormat)
    }

}
