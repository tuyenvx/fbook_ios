//
//  BookDetailViewController.swift
//  FBook
//
//  Created by admin on 5/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SwiftyStarRatingView
import Kingfisher

class BookDetailViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numberPageLabel: UILabel!
    @IBOutlet weak var totalViewLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    enum UserType {
        case watiting
        case review
    }
    
    var userType: UserType = .watiting
    
    var book : Book! {
        didSet {
            if let book = book, self.view != nil {
                self.titleLabel.text = book.title
                self.authorLabel.text = book.author
                self.ratingView.value = book.star
                self.descriptionLabel.text = book.description
                self.numberPageLabel.text = AppStrings.BookDetailViewController.totalPage.rawValue + String(book.totalPage)
                self.totalViewLabel.text = AppStrings.BookDetailViewController.totalView.rawValue + String(book.totalView)
                self.statusLabel.text = book.status
                if let url = URL(string: book.thumbnail) {
                    self.thumbImageView.kf.setImage(with: url, options: [KingfisherOptionsInfoItem.cacheMemoryOnly])
                    self.backgroundImageView.kf.setImage(with: url, options: [KingfisherOptionsInfoItem.cacheMemoryOnly])
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNoTitleBackButton()
        
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.showNavigationBarTraparent()
    }
    
    @IBAction func onChangeSegment(sender: AnyObject) {
        if let segment = sender as? UISegmentedControl {
            switch segment.selectedSegmentIndex {
            case 0:
                self.userType = .watiting
            case 1:
                self.userType = .review
            default:
                self.userType = .watiting
            }
            self.tableView.reloadData()
        }
    }
    
    private func loadData() {
        self.showLoading()
        let input = GetBookDetailInput(bookID: book.id)
        let apiService = BookAPIService()
        apiService.getBookDetail(input) { [weak self] (output, error) in
            self?.hideLoading()
            
            if let output = output {
                self?.book = output.book
                self?.tableView.reloadData()
            }
            if let error = error {
                self?.showAlertError(error: error)
            }
        }
    }
}

extension BookDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch userType {
        case .watiting:
            return book.usersWaiting?.count ?? 0
        case .review:
            return book.reviews?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch userType {
        case .watiting:
            return 44
        case .review:
            return UITableViewAutomaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch userType {
        case .watiting:
            return 44
        case .review:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch userType {
        case .watiting:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemUserWaitingTableViewCell.identifier, for: indexPath)
            if let cell = cell as? ItemUserWaitingTableViewCell {
                cell.user = book.usersWaiting?[indexPath.row]
            }
            return cell
        case .review:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemReviewTableViewCell.identifier, for: indexPath)
            if let cell = cell as? ItemReviewTableViewCell {
                cell.review = book.reviews?[indexPath.row]
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
