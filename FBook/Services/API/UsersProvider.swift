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
    typealias CategorySignal = SignalProducer<[Category], ErrorResponse>
    typealias NotificationSignal = SignalProducer<[NotificationDetail], ErrorResponse>
    typealias FollowInfoSignal = SignalProducer<[User], ErrorResponse>

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

    static func getFavoriteCategoriesOfCurrentUser(userId: Int) -> CategorySignal {
        return requestJSON(api: .getOtherUserProfile(userId)).flatMap(.merge, { object -> CategorySignal in
            if let value = object?.value as? [String: Any], let item = value[kItem] as? [String: Any],
                let user = User(JSON: item) {
                return CategorySignal(value: user.favoriteCategories)
            }
            return CategorySignal(error: .errorJsonFormat)
        })
    }

    static func getListNotifications() -> NotificationSignal {
        return requestJSON(api: .getListNotifications).flatMap(.merge, { object -> NotificationSignal in
            if let value = object?.value as? [String: Any], let items = value[kItems] as? [String: Any],
                let notification = items["notification"] as? [String: Any],
                let notificationModel = Notification(JSON: notification) {
                return NotificationSignal(value: notificationModel.data)
            }
            return NotificationSignal(error: .errorJsonFormat)
        })
    }

    static func getFollowersOfUser(userId: Int) -> FollowInfoSignal {
        return requestJSON(api: .getFollowInfoOfUser(userId)).flatMap(.merge, { object -> FollowInfoSignal in
            if let value = object?.value as? [String: Any],
                let items = value[kItems] as? [String: Any],
                let followers = FollowInfo(JSON: items) {
                return FollowInfoSignal(value: followers.followers)
            }
            return FollowInfoSignal(error: .errorJsonFormat)
        })
    }

    static func getFollowingOfUser(userId: Int) -> FollowInfoSignal {
        return requestJSON(api: .getFollowInfoOfUser(userId)).flatMap(.merge, { object -> FollowInfoSignal in
            if let value = object?.value as? [String: Any],
                let items = value[kItems] as? [String: Any],
                let followingUser = FollowInfo(JSON: items) {
                return FollowInfoSignal(value: followingUser.following)
            }
            return FollowInfoSignal(error: .errorJsonFormat)
        })
    }

    static func followUser(userId: Int) -> BooleanSignal {
        return requestJSON(api: .followUser(userId)).flatMap(.merge, mapBoolean)
    }

}
