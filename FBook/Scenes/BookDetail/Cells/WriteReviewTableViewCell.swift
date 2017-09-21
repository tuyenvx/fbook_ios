//
//  WriteReviewTableViewCell.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class WriteReviewTableViewCell: UITableViewCell {

    var writeReviewButtonTapped: () -> Void = { }

    @IBAction private func writeReviewButtonTapped(_ sender: Any) {
        writeReviewButtonTapped()
    }

}
