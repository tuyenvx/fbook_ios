//
//  SectionBookViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SectionBookViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: SectionBookPresenter?
    var configurator: SectionBookConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(view: self)
        setBackButton()
    }

}

extension SectionBookViewController: SectionBookView {

    func showLoadBooksError(_ message: String) {
        Utility.shared.showMessage(inViewController: self, message: message, completion: nil)
    }

}
