//
//  BaseProvider.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import Moya

class BaseProvider {

    typealias BaseSignal = SignalProducer<ObjectResponse?, ErrorResponse>
    typealias BooleanSignal = SignalProducer<Bool, ErrorResponse>

    static func requestJSON(api: API) -> BaseSignal {
        var request: Cancellable?
        return BaseSignal { signal, _ in
            request = ApiProvider.shared.request(api) { result in
                var response: ObjectResponse? = nil
                var message: MessageResponse? = nil
                var isSuccess = false
                do {
                    let json = try result.dematerialize().mapJSON()
                    if let jsonDic = json as? [String: Any], let messageDic = jsonDic["message"] as? [String: Any] {
                        isSuccess = messageDic["status"] as? Bool ?? true
                        let code = messageDic["code"] as? Int ?? 0
                        let description = messageDic["description"] as? [String] ?? []
                        message = MessageResponse(status: isSuccess, code: code, description: description)
                    } else {
                        isSuccess = true
                    }
                    response = ObjectResponse(value: json, message: message)
                } catch let error as NSError {
                    isSuccess = false
                    message = MessageResponse(status: false, code: error.code,
                        description: [error.localizedDescription])
                }
                if isSuccess {
                    signal.send(value: response)
                    signal.sendCompleted()
                } else {
                    signal.send(error: ErrorResponse(value: response?.value, errorMessage: message))
                }
            }
        }.on(disposed: {
            request?.cancel()
        })
    }

    static let mapBoolean = { (object: ObjectResponse?) -> BooleanSignal in
        if let status = object?.message?.status {
            return BooleanSignal(value: status)
        }
        return BooleanSignal(error: .errorJsonFormat)
    }

}
