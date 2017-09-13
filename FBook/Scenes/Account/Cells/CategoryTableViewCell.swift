//
//  CategoryTableViewCell.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func updateCell(categoryName: String) {
        categoryNameLabel?.text = categoryName
    }

}
