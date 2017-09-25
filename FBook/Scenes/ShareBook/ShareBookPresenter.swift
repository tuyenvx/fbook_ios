//
//  ShareBookPresenter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Photos
import QBImagePickerController

enum ItemType {

    case category
    case publishDate
    case office

}

protocol ShareBookView: class {

    func updateUI()
    func displayChooseImageSourceDialog()

}

protocol ShareBookPresenter {

    func configure(collectionView: UICollectionView, height: NSLayoutConstraint)
    func configure(textFields: UITextField...)
    func openCamera()
    func openPhotoLibrary()
    func displaySelectItems(type: ItemType)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)

}

class ShareBookPresenterImpl: NSObject {

    private(set) var router: ShareBookViewRouter?
    fileprivate weak var view: ShareBookView?

    var photos = [UIImage]()
    let numberOfCells: CGFloat = 2.0
    let photoRatio: CGFloat = 3.0 / 4.0
    var cellWidth: CGFloat = 0.0
    var cellHeight: CGFloat = 0.0
    var currentItemType = ItemType.category

    init(view: ShareBookView, router: ShareBookViewRouter) {
        self.view = view
        self.router = router
    }

    fileprivate func displayChooseImageSourceDialog() {
        view?.displayChooseImageSourceDialog()
    }

}

// MARK: - ShareBookPresenter

extension ShareBookPresenterImpl: ShareBookPresenter {

    func configure(collectionView: UICollectionView, height: NSLayoutConstraint) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNibCell(type: PhotoCollectionViewCell.self)
        cellWidth = (UIScreen.main.bounds.width - 16.0) / numberOfCells
        cellHeight = (cellWidth - 16.0) / photoRatio
        height.constant = cellHeight
    }

    func configure(textFields: UITextField...) {
        textFields.forEach({ $0.delegate = self })
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            router?.present(viewControllerToPresent: imagePickerController)
        } else {
            // TODO: Display camera error message
        }
    }

    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = QBImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsMultipleSelection = true
            imagePickerController.mediaType = .image
            router?.present(viewControllerToPresent: imagePickerController)
        } else {
            // TODO: Display photo library error message
        }
    }
    
    func displaySelectItems(type: ItemType) {
        currentItemType = type
        router?.performSegue(withIdentifier: "selectItems")
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemPickerViewController = segue.destination as? ItemPickerViewController {
            // TODO: Add items
            let items: [String] = []
            switch currentItemType {
            case .category: break
            case .publishDate: break
            case .office: break
            }
            itemPickerViewController.configurator = ItemPickerConfiguratorImpl(items: items)
        }
    }

}

// MARK: - UICollectionViewDataSource

extension ShareBookPresenterImpl: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count + 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableNibCell(type: PhotoCollectionViewCell.self, atIndex: indexPath)
              else {
            return UICollectionViewCell()
        }
        let photo = photos[safe: indexPath.row]
        cell.updateUI(photo: photo)
        cell.addPhoto = { [weak self] in
            self?.displayChooseImageSourceDialog()
        }
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension ShareBookPresenterImpl: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension ShareBookPresenterImpl: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let photo = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true) {
            self.photos.append(photo)
            self.view?.updateUI()
        }
    }

}

// MARK: - QBImagePickerControllerDelegate

extension ShareBookPresenterImpl: QBImagePickerControllerDelegate {

    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }

    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!,
                                  didFinishPickingAssets assets: [Any]!) {
        let imageManager = PHImageManager()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        assets.forEach({
            guard let asset = $0 as? PHAsset else {
                return
            }
            let imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit,
                options: options) { [weak self] (image, _) in
                    guard let image = image else {
                        return
                    }
                    self?.photos.append(image)
                }
        })
        imagePickerController.dismiss(animated: true) {
            self.view?.updateUI()
        }
    }

}

// MARK: - UITextFieldDelegate

extension ShareBookPresenterImpl: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
}
