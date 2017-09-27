//
//  PickerTableViewCell.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol PickerCellView {
    func display(title: String?, isChecked: Bool)
}

class PickerTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var checkImageView: UIImageView!

}

extension PickerTableViewCell: PickerCellView {

    func display(title: String?, isChecked: Bool) {
        titleLabel?.text = title ?? "All"
        checkImageView?.isHidden = !isChecked
    }

}
