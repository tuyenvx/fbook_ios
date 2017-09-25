//
//  ShareBookViewController.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ShareBookViewController: BaseViewController {

    var presenter: ShareBookPresenter?
    var configurator: ShareBookConfiguratorImpl?

    @IBOutlet fileprivate weak var photosCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var collectionViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = ShareBookConfiguratorImpl()
        configurator?.configure(viewController: self)
        presenter?.configure(collectionView: photosCollectionView, height: collectionViewHeightConstraint)
    }

}

extension ShareBookViewController: ShareBookView {

    func updateUI() {
        photosCollectionView.reloadData()
        let lastIndex = photosCollectionView.numberOfItems(inSection: 0) - 1
        photosCollectionView.scrollToItem(at: IndexPath(row: lastIndex, section: 0), at: .right, animated: true)
    }

    func displayChooseImageSourceDialog() {
        let openCameraAction = UIAlertAction(title: "Take photo from camera", style: .default) { [weak self] _ in
            self?.presenter?.openCamera()
        }
        let openPhotoLibraryAction = UIAlertAction(title: "Choose from library", style: .default) { [weak self] _ in
            self?.presenter?.openPhotoLibrary()
        }
        Utility.shared.showActionSheet(in: self, actions: openCameraAction, openPhotoLibraryAction)
    }

}
