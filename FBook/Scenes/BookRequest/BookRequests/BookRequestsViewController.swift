//
//  BookRequestsViewController.swift
//  FBook
//
//  Created by Huy Pham on 9/20/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class BookRequestsViewController: UIViewController {

    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var ownersLabel: UILabel!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var countViewLabel: UILabel!
    @IBOutlet fileprivate weak var ratingView: CosmosView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: BookRequestsPresenter?
    var configurator: BookRequestsConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.loadBook()
        presenter?.configureTableView()
    }
}

extension BookRequestsViewController: BookRequestsView {

    func display(book: Book) {
        photoImageView.setImage(urlString: book.thumbnail, placeHolder: #imageLiteral(resourceName: "img_placeholder_book"))
        nameLabel.text = book.title
        authorLabel.text = book.author
        descriptionLabel.text = book.description
        ratingView.rating = book.averageStar
        countViewLabel.text = "View: \(book.totalView)"
        var listOwners = ""
        if let owners = book.users?.owners {
            for owner in owners {
                if listOwners == "" {
                    listOwners += owner.name
                } else {
                    listOwners += ", \(owner.name)"
                }
            }
        }
        ownersLabel.text = "Shared by: \(listOwners)"
    }
}
