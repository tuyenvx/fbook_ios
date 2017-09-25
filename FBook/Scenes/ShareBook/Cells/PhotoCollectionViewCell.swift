//
//  PhotoCollectionViewCell.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var addPhotoView: UIView!

    var addPhoto: () -> Void = { }

    func updateUI(photo: UIImage?) {
        imageView.image = photo
        addPhotoView.isHidden = photo != nil
    }

    @IBAction private func addPhotoButtonTapped(_ sender: Any) {
        addPhoto()
    }

}
