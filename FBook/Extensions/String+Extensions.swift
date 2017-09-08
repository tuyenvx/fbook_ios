//
//  String+Extensions.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

extension String {

    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: self)
    }

}
