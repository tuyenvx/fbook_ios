//
//  Array+Extensions.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

extension Array {

    mutating func remove(safeAt index: Index) {
        guard index >= 0 && index < count else {
            return
        }
        remove(at: index)
    }

    mutating func insert(_ element: Element, safeAt index: Index) {
        guard index >= 0 && index <= count else {
            return
        }
        insert(element, at: index)
    }

    subscript (safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            remove(safeAt: index)
            if let element = newValue {
                insert(element, safeAt: index)
            }
        }
    }

}
