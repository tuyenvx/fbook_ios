//
//  HeaderSectionBooksView.swift
//  FBook
//
//  Created by admin on 5/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class HeaderSectionBooksView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    class var identifier: String {
        return "HeaderSectionBooksView"
    }
    
    class var height: CGFloat {
        return 50
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
    }
}
