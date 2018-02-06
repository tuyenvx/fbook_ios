//
//  OwnerCollectionViewCell.swift
//  FBook
//
//  Created by TuyenVX on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class OwnerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func displayBookRequest(_ bookRequest: BookRequest) {
        ownerNameLabel.text = bookRequest.name
        ownerAvatarImageView.setImage(urlString: bookRequest.avatar, placeHolder: #imageLiteral(resourceName: "icon_author"))
    }

}
