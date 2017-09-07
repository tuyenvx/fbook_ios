//
//  AuthenticationProvider.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift

final class AuthenticationProvider: BaseProvider {

    typealias LoginSignal = SignalProducer<String, ErrorResponse>

    static func login(email: String, password: String) -> LoginSignal {
        return requestJSON(api: .login(email, password)).flatMap(FlattenStrategy.merge, { object -> LoginSignal in
            if let value = object?.value as? [String: Any], let fauth = value[kFauth] as? [String: Any],
                let accessToken = fauth[kAccessToken] as? String {
                return LoginSignal(value: accessToken)
            }
            return LoginSignal(error: .errorJsonFormat)
        })
    }

}
