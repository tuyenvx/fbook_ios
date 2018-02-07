//
//  InforPerssonTableViewCell.swift
//  FBook
//
//  Created by ThietTB on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class InforPerssonTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var idPersonal: UILabel!
    @IBOutlet weak var position: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func displayProfile(_ user: User?) {
        name?.text = user?.name
        email?.text = user?.email
        phone?.text = user?.phone
        idPersonal?.text = user?.code
        position?.text = user?.position
    }
}
