//
//  ShareByTableViewCell.swift
//  FBook
//
//  Created by TuyenVX on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit
import RxSwift

class ShareByTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: ShareByTableViewCellPresent?
    var configurator: ShareByTableViewConfigurator?

    func config() {
        configurator?.config(view: self)
    }
}
extension ShareByTableViewCell: ShareByTableViewCellView {
    func displayConfigurator(_ configurator: ShareByTableViewConfigurator?) {
        self.configurator = configurator
        self.configurator?.config(view: self)
        presenter?.configure(collectionView: collectionView)
        presenter?.loadCell()
    }

    func refreshOwners() {
        collectionView.reloadData()
    }
}
