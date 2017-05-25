//
//  DataTransform.swift
//  FBook
//
//  Created by admin on 5/24/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import ObjectMapper

class DoubleTransform: TransformType {
    public typealias Object = Double
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Double? {
        guard let string = value as? String else{
            return nil
        }
        return Double(string)
    }
    
    open func transformToJSON(_ value: Double?) -> String? {
        guard let data = value else{
            return nil
        }
        return String(data)
    }
}

class IntTransform: TransformType {
    public typealias Object = Int
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Int? {
        guard let string = value as? String else{
            return nil
        }
        return Int(string)
    }
    
    open func transformToJSON(_ value: Int?) -> String? {
        guard let data = value else{
            return nil
        }
        return String(data)
    }
}
