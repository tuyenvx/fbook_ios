//
//  BookingBookParams.swift
//  FBook
//
//  Created by Huy Pham on 9/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum BookingStatus: Int {

    case waiting = 1
    case reading = 2
    case returning = 3
    case returned = 4
    case cancel = 5

    func toString() -> String {
        switch self {
        case .waiting:
            return "waiting"
        case .reading:
            return "reading"
        case .returning:
            return "returning"
        case .returned:
            return "returned"
        case .cancel:
            return "cancel"
        }
    }

    var color: UIColor {
        switch self {
        case .waiting, .returning, .cancel:
            return #colorLiteral(red: 0.8274509804, green: 0.6235294118, blue: 0.3254901961, alpha: 1)
        case .reading, .returned:
            return #colorLiteral(red: 0.3568627451, green: 0.6823529412, blue: 0.3843137255, alpha: 1)
        }
    }
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
