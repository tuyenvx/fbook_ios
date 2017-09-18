//
//  CategoryViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: CategoryPresenter?
    var configurator: CategoryConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(view: self)
    }

}

extension CategoryViewController: CategoryView {

}
