//
//  HeaderTableViewCell.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SwiftHEXColors

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarUserImage: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!

    var handleButtonFollowTapped: (Bool) -> Void = {_ in}

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setBackgroundCell() {
        self.backgroundColor = UIColor(hexString: "#E01D1C")
    }

    func displayUser(_ user: User) {
        avatarUserImage.setImage(urlString: user.avatar, placeHolder: kDefaultAvatar)
        userNameLabel.text = user.name
    }

    @IBAction func onButtonFollowTapped(_ sender: Any) {
        handleButtonFollowTapped(followButton.isSelected)
    }

    func followButtonEnable() {
        followButton.isSelected = false
        followButton.borderColor = .clear
        followButton.setBackgroundImage(UIImage(named: "background_button_follow"), for: .normal)
    }

    func unfollowButtonEnable() {
        followButton.isSelected = true
        followButton.setBackgroundImage(UIImage(named: ""), for: .normal)
        followButton.borderWidth = 1
        followButton.borderColor = .white
    }
}
