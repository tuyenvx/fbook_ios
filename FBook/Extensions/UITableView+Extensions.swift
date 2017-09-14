//
//  UITableView+Extensions.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func registerNibCell<T: UITableViewCell>(type: T.Type) {
        register(UINib.nib(fromClass: type), forCellReuseIdentifier: String(describing: type))
    }

    func registerNibHeaderFooter<T: UITableViewHeaderFooterView>(type: T.Type) {
        register(UINib.nib(fromClass: type), forHeaderFooterViewReuseIdentifier: String(describing: type))
    }

    func dequeueReusableNibCell<T: UITableViewCell>(type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type)) as? T
    }

    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T
    }

}
