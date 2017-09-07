//
//  HomeProvider.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import ObjectMapper

final class HomeProvider: BaseProvider {

    typealias ListSectionBookSignal = SignalProducer<[SectionBook], ErrorResponse>

    static func getListSectionBook() -> ListSectionBookSignal {
        return requestJSON(api: .home).flatMap(.merge) { object -> ListSectionBookSignal in
            if let value = object?.value as? [String: Any], let items = value[kItems] as? [[String: Any]] {
                return ListSectionBookSignal(value: Mapper<SectionBook>().mapArray(JSONArray: items))
            }
            return ListSectionBookSignal(error: .errorJsonFormat)
        }
    }

}
