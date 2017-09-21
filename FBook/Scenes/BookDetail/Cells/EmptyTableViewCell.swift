//
//  EmptyTableViewCell.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet private weak var messageLabel: UILabel!

    func updateUI(message: String) {
        messageLabel.text = message
    }

}
