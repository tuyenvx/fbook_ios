//
//  BaseListBooksView.swift
//  FBook
//
//  Created by admin on 5/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol ListBooksViewDelegate: class {
    func listBookViewShouldLoadMore() -> Bool
    func listBookViewLoadMore()
    func listBookViewShouldPullToRefresh() -> Bool
    func listBookViewPullToRefresh()
    
    // optional
    func listBookViewDidSelect(_ book: Book)
}

extension ListBooksViewDelegate {
    func listBookViewDidSelect(_ book: Book) {}
}

class ListBooksView: UIView {

    private var collectionView : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: GradientShadowAtBottomCollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.clear
        self.addSubview(collectionView)
        
        collectionView.register(UINib(nibName: ItemBookCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemBookCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: LoadingCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: LoadingCollectionReusableView.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    fileprivate var pageList: PageList<Book>?
    
    weak var delegate: ListBooksViewDelegate? {
        didSet {
            if let delegate = delegate, delegate.listBookViewShouldPullToRefresh() {
                collectionView.setupPullToRefresh()
                collectionView.mj_header.refreshingBlock = { [weak self] in
                    self?.delegate?.listBookViewPullToRefresh()
                }
            }
        }
    }
    
    var numberOfItemsInLine = 3
    
    var currentPage: Int {
        get {
            return pageList?.currentPage ?? 0
        }
        set {
            pageList?.currentPage = newValue
        }
    }
    
    var totalItems: Int {
        get {
            return pageList?.totalItems ?? 0
        }
        set {
            pageList?.totalItems = newValue
        }
    }
    
    var nextPage: Int? {
        get {
            return pageList?.nextPage
        }
    }
    
    var itemCount: Int {
        return pageList?.models.count ?? 0
    }
    
    var canLoadMore: Bool {
        guard let pageList = self.pageList else {
            return false
        }
        return pageList.nextPage != nil
    }
    
    func setData(_ pageList: PageList<Book>) {
        self.pageList = pageList
    }

    func appendData(_ pageList: PageList<Book>) {
        if let currentPageList = self.pageList {
            currentPageList.totalItems = pageList.totalItems
            currentPageList.currentPage = pageList.currentPage
            currentPageList.nextPage = pageList.nextPage
            currentPageList.prevPage = pageList.prevPage
            currentPageList.models.append(contentsOf: pageList.models)
        }
        else {
            self.pageList = pageList
        }
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func endRefreshing() {
        if let mj_header = self.collectionView.mj_header {
            mj_header.endRefreshing()
        }
    }
}

extension ListBooksView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemBookCollectionViewCell.identifier, for: indexPath)
        
        if let cell = cell as? ItemBookCollectionViewCell {
            cell.book = self.pageList?.models[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let book = self.pageList?.models[indexPath.row] {
            self.delegate?.listBookViewDidSelect(book)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if canLoadMore {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if self.canLoadMore, let delegate = delegate, delegate.listBookViewShouldLoadMore() {
            delegate.listBookViewLoadMore()
        }
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingCollectionReusableView.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: ItemBookCollectionViewCell.spaceForItem, left: ItemBookCollectionViewCell.spaceForItem, bottom: 0, right: ItemBookCollectionViewCell.spaceForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - ItemBookCollectionViewCell.spaceForItem * CGFloat(numberOfItemsInLine + 1)) / CGFloat(numberOfItemsInLine)
        let height = width * 1.8
        return CGSize(width: width, height: height)
    }
    
}
