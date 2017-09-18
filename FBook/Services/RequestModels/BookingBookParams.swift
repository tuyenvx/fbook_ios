//
//  BookingBookParams.swift
//  FBook
//
//  Created by Huy Pham on 9/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

enum BookingStatus: Int {

    case waiting = 1
    case returning = 3
    case returned = 4
    case cancel = 5
}

class BookingBookParams {

    var book: Book?
    var owner: User?
    var status: BookingStatus = .waiting

    func toRequestJSON() -> [String: Any] {
        var json = ["status": status.rawValue]
        if let id = book?.id {
            json["book_id"] = id
        }
        if let id = owner?.id {
            json["owner_id"] = id
        }
        return json
    }
}
