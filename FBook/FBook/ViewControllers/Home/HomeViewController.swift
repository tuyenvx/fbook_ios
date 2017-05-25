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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: HeaderSectionBooksView.identifier, bundle: nil),
                           forHeaderFooterViewReuseIdentifier: HeaderSectionBooksView.identifier)
    }

    

}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderSectionBooksView.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSectionBooksView.identifier) as? HeaderSectionBooksView
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
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionHome.sectionCount.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == SectionHome.sectionBook.rawValue {
            return 5
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == SectionHome.sectionBook.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemBookCollectionViewCell.identifier, for: indexPath)
            
            if let bookCell = cell as? ItemBookCollectionViewCell {
                
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
                tabBarController.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowBookDetail, sender: nil)
            }
            else {
                tabBarController.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowListBook, sender: nil)
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
