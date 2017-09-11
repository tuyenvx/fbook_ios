//
//  UICollectionView+Extensions.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerNibCell<T: UICollectionViewCell>(type: T.Type) {
        register(UINib.nib(fromClass: type), forCellWithReuseIdentifier: String(describing: type))
    }

    func dequeueReusableNibCell<T: UICollectionViewCell>(type: T.Type, atIndex: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: atIndex) as? T
    }

}
