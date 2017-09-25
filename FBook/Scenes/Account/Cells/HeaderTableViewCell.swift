//
//  HeaderTableViewCell.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarUserImage: UIImageView!
    @IBOutlet weak var followButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func displayAvatar(_ user: User) {
        avatarUserImage.setImage(urlString: user.avatar, placeHolder: kDefaultAvatar)
    }
}
