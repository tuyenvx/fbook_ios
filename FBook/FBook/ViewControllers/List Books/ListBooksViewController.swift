//
//  ListBookViewController.swift
//  FBook
//
//  Created by admin on 5/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ListBooksViewController: UIViewController {

    @IBOutlet weak var listBookView: ListBooksView!
    
    enum ListBooksType {
        case section(key: String, title: String)
        case myBookShare
        
        var title : String {
            switch self {
            case .section( _, let title):
                return title
            default: return String(describing: self)
            }
        }
        
        var key : String {
            switch self {
            case .section(let key, _):
                return key
            default: return String(describing: self)
            }
        }
    }
    
    var listBooksType: ListBooksType!
    
    fileprivate var isLoadingData = false
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.showNavigationBarDefault()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNoTitleBackButton()
        self.navigationItem.title = listBooksType.title
        self.listBookView.delegate = self
        self.loadData()
    }
    
    fileprivate func loadData() {
        guard !self.isLoadingData else {
            return
        }
        self.isLoadingData = true
        self.showLoading()
        let input = GetListBookOfSectionInput(key: listBooksType.key, page: 0)
        let apiService = BookAPIService()
        apiService.getListBookOfSection(input) { [weak self] (output, error) in
            self?.isLoadingData = false
            self?.hideLoading()
            self?.listBookView.endRefreshing()
            
            if let output = output {
                self?.listBookView.setData(output.pageList)
                self?.listBookView.reloadData()
            }
            if let error = error {
                self?.showAlertError(error: error)
            }
        }
    }
    
    fileprivate func loadMore() {
        guard self.listBookView.canLoadMore else {
            return
        }
        guard let nextPage = self.listBookView.nextPage else {
            return
        }
        guard !self.isLoadingData else {
            return
        }
        self.isLoadingData = true
        let input = GetListBookOfSectionInput(key: listBooksType.key, page: nextPage)
        let apiService = BookAPIService()
        apiService.getListBookOfSection(input) { [weak self] (output, error) in
            self?.isLoadingData = false
            
            if let output = output {
                self?.listBookView.appendData(output.pageList)
                self?.listBookView.reloadData()
            }
            if let error = error {
                self?.showAlertError(error: error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStoryboards.segueIdentifierShowBookDetail {
            if let vc = segue.destination as? BookDetailViewController {
                if let book = sender as? Book {
                    vc.book = book
                }
            }
        }
    }
}

extension ListBooksViewController: ListBooksViewDelegate {
    func listBookViewShouldLoadMore() -> Bool {
        return !self.isLoadingData
    }
    
    func listBookViewLoadMore() {
        print("Load more...")
        self.loadMore()
    }
    
    func listBookViewShouldPullToRefresh() -> Bool {
        return true
    }
    
    func listBookViewPullToRefresh() {
        self.loadData()
    }
    
    func listBookViewDidSelect(_ book: Book) {
        self.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowBookDetail, sender: book)
    }
    
}
