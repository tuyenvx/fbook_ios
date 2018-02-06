//
//  ShareByTableViewCellPresenter.swift
//  FBook
//
//  Created by TuyenVX on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol ShareByTableViewCellView: AnyObject {
    func displayConfigurator(_ configurator: ShareByTableViewConfigurator?)
    func refreshOwners()
}

protocol ShareByTableViewCellDelegate: AnyObject {
    func didSelectedOwner(_ owner: BookRequest)
}

protocol ShareByTableViewCellPresent: AnyObject {
    func loadCell()
    func configure(collectionView: UICollectionView)
}

class ShareByTableViewCellPresentImplement: NSObject {
    fileprivate weak var view: ShareByTableViewCellView?
    weak var delegate: ShareByTableViewCellDelegate?
    var owners: [BookRequest]

    init(view: ShareByTableViewCellView, owners: [BookRequest], delegate: ShareByTableViewCellDelegate?) {
        self.view = view
        self.owners = owners
        self.delegate = delegate
    }
}

extension ShareByTableViewCellPresentImplement: ShareByTableViewCellPresent {
    func loadCell() {
        view?.refreshOwners()
    }

    func configure(collectionView: UICollectionView) {
        collectionView.registerNibCell(type: OwnerCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ShareByTableViewCellPresentImplement: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCollection = collectionView.frame.size
        return CGSize(width: 100, height: sizeCollection.height)
    }
}

extension ShareByTableViewCellPresentImplement: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return owners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableNibCell(type: OwnerCollectionViewCell.self, atIndex: indexPath),
                let owner = owners[safe: indexPath.row] else {
                    return UICollectionViewCell()
            }
            cell.displayBookRequest(owner)
            return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedOwner(owners[indexPath.row])
    }
}
