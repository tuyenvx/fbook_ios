//
//  UserTableViewCell.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/15/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!

    func updateUI(user: User, status: String) {
        avatarImageView.setImage(urlString: user.avatar, placeHolder: kDefaultAvatar)
        fullNameLabel.text = user.name
        statusLabel.text = status
    }

}
