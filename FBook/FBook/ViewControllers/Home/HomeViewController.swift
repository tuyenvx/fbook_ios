//
//  HomeViewController.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum SectionHome: Int {
        case sectionBook = 0, sectionViewAll, sectionCount
    }
    
    var sectionsBook: [SectionBook]?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: HeaderSectionBooksView.identifier, bundle: nil),
                           forHeaderFooterViewReuseIdentifier: HeaderSectionBooksView.identifier)
        self.tableView.setupPullToRefresh()
        self.tableView.mj_header.refreshingBlock = { [weak self] in
            self?.loadData()
        }
        self.loadData()
    }

    private func loadData() {
        self.showLoading()
        let input = GetHomePageInput()
        let apiService = BookAPIService()
        apiService.getHomePage(input) { [weak self] (output, error) in
            self?.hideLoading()
            self?.tableView.mj_header.endRefreshing()
            
            if let output = output {
                self?.sectionsBook = output.sectionsBook
                self?.tableView.reloadData()
            }
            if let error = error {
                self?.showAlertError(error: error)
            }
        }
    }
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsBook?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderSectionBooksView.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSectionBooksView.identifier) as? HeaderSectionBooksView
        view?.titleLabel.text = sectionsBook?[section].sort.title ?? ""
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemBookCollectionViewCell.size.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemSectionBooksTableViewCell.identifier, for: indexPath)
        if let cell = cell as? ItemSectionBooksTableViewCell {
            cell.collectionView.tag = indexPath.section
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionHome.sectionCount.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == SectionHome.sectionBook.rawValue {
            return sectionsBook?[collectionView.tag].books?.count ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == SectionHome.sectionBook.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemBookCollectionViewCell.identifier, for: indexPath)
            
            if let cell = cell as? ItemBookCollectionViewCell {
                cell.book = sectionsBook?[collectionView.tag].books?[indexPath.row]
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemViewAllCollectionViewCell", for: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let tabBarController = self.tabBarController as? TabBarController {
            if indexPath.section == SectionHome.sectionBook.rawValue {
                tabBarController.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowBookDetail, sender: sectionsBook?[collectionView.tag].books?[indexPath.row])
            }
            else {
                tabBarController.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowListBook, sender: sectionsBook?[collectionView.tag])
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == SectionHome.sectionBook.rawValue {
            return UIEdgeInsets(top: 0, left: ItemBookCollectionViewCell.spaceForItem, bottom: 0, right: ItemBookCollectionViewCell.spaceForItem)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: ItemBookCollectionViewCell.spaceForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ItemBookCollectionViewCell.spaceForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ItemBookCollectionViewCell.size
    }
    
}
