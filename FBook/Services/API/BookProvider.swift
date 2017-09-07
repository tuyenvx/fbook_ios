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

    static func getBookDetail(bookId: Int) -> BookDetailSignal {
        return requestJSON(api: .getBookDetail(bookId)).flatMap(.merge) { object -> BookDetailSignal in
            if let value = object?.value as? [String: Any], let item = value[kItem] as? [String: Any],
                    let bookDetail = BookDetail(JSON: item) {
                return BookDetailSignal(value: bookDetail)
            }
            return BookDetailSignal(error: .errorJsonFormat)
        }
    }

}
