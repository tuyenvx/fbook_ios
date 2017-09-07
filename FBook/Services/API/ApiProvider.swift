//
//  ApiProvider.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import Moya
import Alamofire

public struct ApiProvider {

    fileprivate static var endpointClosure = {
        (target: API) -> Endpoint<API> in
        return Endpoint<API>(
            url: url(target),
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            parameters: target.parameters,
            parameterEncoding: target.parameterEncoding)
    }

    fileprivate static var networkActivityClosure = {
        (change: NetworkActivityChangeType) -> Void in
        UIApplication.shared.isNetworkActivityIndicatorVisible = (change == .began)
    }

    fileprivate static func getDefaultProvider() -> MoyaProvider<API> {
        let plugins: [PluginType] = [
            NetworkLoggerPlugin(verbose: true),
            NetworkActivityPlugin(networkActivityClosure: networkActivityClosure)
        ]
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let newManager = Alamofire.SessionManager(configuration: configuration)
        return MoyaProvider<API>(endpointClosure: endpointClosure, manager: newManager, plugins: plugins)
    }

    fileprivate static func getAuthenticatedProvider(_ token: String) -> MoyaProvider<API> {
        let plugins: [PluginType] = [
            NetworkLoggerPlugin(verbose: true),
            NetworkActivityPlugin(networkActivityClosure: networkActivityClosure),
            AccessTokenPlugin(token: token)
        ]
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        let newManager = Alamofire.SessionManager(configuration: configuration)
        return MoyaProvider<API>(endpointClosure: endpointClosure, manager: newManager, plugins: plugins)
    }

    fileprivate static var authenticatedProvider: MoyaProvider<API>?
    fileprivate static let defaultProvider = getDefaultProvider()

    public static var accessToken: String? {
        get {
            return userDefaults.value(forKey: kAccessTokenKey) as? String
        }
        set {
            if let value = newValue {
                authenticatedProvider = getAuthenticatedProvider(value)
            } else {
                authenticatedProvider = nil
            }
            userDefaults.set(newValue, forKey: kAccessTokenKey)
            userDefaults.synchronize()
        }
    }

    public static var shared: MoyaProvider<API> {
        if let authenticatedProvider = authenticatedProvider {
            return authenticatedProvider
        } else if let accessToken = accessToken {
            authenticatedProvider = getAuthenticatedProvider(accessToken)
            return authenticatedProvider ?? defaultProvider
        }
        return defaultProvider
    }

}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
