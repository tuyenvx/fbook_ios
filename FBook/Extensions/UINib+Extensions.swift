//
//  UINib+Extensions.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

extension UINib {

    static func nib<T: NSObject>(fromClass type: T.Type) -> UINib? {
        let name = String(describing: type)
        if Bundle.main.path(forResource: name, ofType: "nib") != nil ||
            Bundle.main.path(forResource: name, ofType: "xib") != nil {
            return UINib(nibName: String(describing: T.self), bundle: nil)
        }
        return nil
    }

}
