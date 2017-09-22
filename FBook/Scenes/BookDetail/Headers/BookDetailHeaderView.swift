//
//  BookDetailHeaderView.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BookDetailHeaderView: UITableViewHeaderFooterView {

    var changeDetailType: (Int) -> Void = { _ in }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        changeDetailType(sender.selectedSegmentIndex)
    }

}
