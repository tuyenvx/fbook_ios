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
    @IBOutlet fileprivate weak var titleTextField: CustomTextField!
    @IBOutlet fileprivate weak var authorTextField: CustomTextField!
    @IBOutlet fileprivate weak var categoryTextField: CustomTextField!
    @IBOutlet fileprivate weak var publishDateTextField: CustomTextField!
    @IBOutlet fileprivate weak var officeTextField: CustomTextField!
    @IBOutlet fileprivate weak var collectionViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = ShareBookConfiguratorImpl()
        configurator?.configure(viewController: self)
        presenter?.configure(collectionView: photosCollectionView, height: collectionViewHeightConstraint)
        presenter?.configure(textFields: categoryTextField, publishDateTextField, officeTextField)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter?.prepare(for: segue, sender: sender)
    }

    // MARK: - IBAction

    @IBAction func categoryTextFieldTapped(_ sender: Any) {
    	presenter?.displaySelectItems(type: .category)
    }

    @IBAction func publishDateTextFieldTapped(_ sender: Any) {
    	presenter?.displaySelectItems(type: .publishDate)
    }

    @IBAction func officeTextFieldTapped(_ sender: Any) {
    	presenter?.displaySelectItems(type: .office)
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
