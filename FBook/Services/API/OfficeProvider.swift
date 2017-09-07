//
//  OfficeProvider.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import ObjectMapper

final class OfficeProvider: BaseProvider {

    typealias ListOfficeSignal = SignalProducer<[Office], ErrorResponse>

    static func getListOffice() -> ListOfficeSignal {
        return requestJSON(api: .getListOffice).flatMap(FlattenStrategy.merge) { object -> ListOfficeSignal in
            if let value = object?.value as? [String: Any], let items = value[kItems] as? [[String: Any]] {
                return ListOfficeSignal(value: Mapper<Office>().mapArray(JSONArray: items))
            }
            return ListOfficeSignal(error: .errorJsonFormat)
        }
    }

}
