//
//  ProfileTableViewCell.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func displayProfile(_ user: User) {
        userNameLabel?.text = user.name
        emailLabel?.text = user.email
        phoneLabel?.text = user.phone
        codeLabel?.text = user.code
        positionLabel?.text = user.position
    }
}
