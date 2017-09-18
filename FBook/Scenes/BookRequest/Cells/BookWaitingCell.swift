//
//  BookWaitingCell.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class BookWaitingCell: UITableViewCell {

    @IBOutlet fileprivate weak var bookPhoto: UIImageView!
    @IBOutlet fileprivate weak var ownersLabel: UILabel!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var ratingView: CosmosView!

    @IBAction fileprivate func onViewAllRequestTapped(_ sender: UIButton) {
    }
}
