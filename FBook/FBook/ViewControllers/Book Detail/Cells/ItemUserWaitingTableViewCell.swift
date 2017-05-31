//
//  ItemUserWaitingTableViewCell.swift
//  FBook
//
//  Created by admin on 5/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ItemUserWaitingTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    class var identifier: String {
        return "ItemUserWaitingTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = ""
    }
    
    var user : User? {
        didSet {
            if let user = user {
                self.nameLabel.text = user.name
            }
        }
    }
}
