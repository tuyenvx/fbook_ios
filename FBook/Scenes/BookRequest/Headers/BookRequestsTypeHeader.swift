//
//  BookRequestsTypeHeader.swift
//  FBook
//
//  Created by Huy Pham on 9/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BookRequestsTypeHeader: UITableViewHeaderFooterView {

    weak var presenter: BookRequestsPresenter?

    @IBAction func requestCategoryChanged(_ sender: UISegmentedControl) {
        if let type = BookRequestType(rawValue: sender.selectedSegmentIndex) {
            presenter?.changeRequestType(type)
        }
    }
}
