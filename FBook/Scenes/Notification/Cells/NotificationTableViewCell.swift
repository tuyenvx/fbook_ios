//
//  NotificationTableViewCell.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Kingfisher

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarUserImage: UIImageView!
    @IBOutlet weak var notificationDetailLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(notification: NotificationDetail) {
        guard let time = notification.updatedAt?.timeAgoDisplay(),
            let user = notification.userSend,
            let targetName = notification.target?.title,
            let userNameSend = notification.userSend?.name else {return}
        let type = notification.type
        notificationDetailLabel?.text = "\(targetName) \(type) by \(userNameSend)"
        avatarUserImage.setImage(urlString: user.avatar, placeHolder: kDefaultAvatar)
        timeLabel.text = time
    }

}
