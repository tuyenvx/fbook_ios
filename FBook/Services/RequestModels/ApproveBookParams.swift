//
//  ApproveBookParams.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

enum ApproveType: String {

    case approve
    case unapprove
}

struct ApproveBookParams {

    var key: ApproveType = .approve
    var userId: Int?

    func toRequestJSON() -> [String: Any] {
        var json: [String: [String: Any]] = [kItem: ["key": key.rawValue]]
        if let id = userId {
            json[kItem]?["user_id"] = id
        }
        return json
    }
}
