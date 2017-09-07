//
//  UsersProvider.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import ObjectMapper

final class UsersProvider: BaseProvider {

    typealias UserSignal = SignalProducer<User, ErrorResponse>

    static func getUserProfile() -> UserSignal {
        return requestJSON(api: .getUserProfile).flatMap(.merge, { object -> UserSignal in
            if let value = object?.value as? [String: Any], let item = value[kItem] as? [String: Any],
                let user = User(JSON: item) {
                return UserSignal(value: user)
            }
            return UserSignal(error: .errorJsonFormat)
        })
    }

    static func getOtherUserProfile(userId: Int) -> UserSignal {
        return requestJSON(api: .getOtherUserProfile(userId)).flatMap(.merge, { object -> UserSignal in
            if let value = object?.value as? [String: Any], let item = value[kItem] as? [String: Any],
                let user = User(JSON: item) {
                return UserSignal(value: user)
            }
            return UserSignal(error: .errorJsonFormat)
        })
    }

}
