//
//  ChooseWorkspaceTableViewCell.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol ChooseWorkspaceCellView {
    func displayOffice(_ office: Office?, isChecked: Bool)
}

class ChooseWorkspaceTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var checkImageView: UIImageView!

}

extension ChooseWorkspaceTableViewCell: ChooseWorkspaceCellView {

    func displayOffice(_ office: Office?, isChecked: Bool) {
        titleLabel?.text = office?.name ?? "All"
        checkImageView?.isHidden = !isChecked
    }

}
