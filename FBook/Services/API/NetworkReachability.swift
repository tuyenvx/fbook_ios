//
//  NetworkReachability.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import Alamofire

class NetworkReachability {

    static let shared = NetworkReachability()

    fileprivate let networkReachability = NetworkReachabilityManager()
    static private(set) var isReachable = true

    private init() {
        networkReachability?.startListening()
        networkReachability?.listener = { [weak self] status in
            NetworkReachability.isReachable = self?.networkReachability?.isReachable ?? false
        }
    }

}
