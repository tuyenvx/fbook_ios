//
//  ListFilterViewController.swift
//  FBook
//
//  Created by admin on 5/23/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol ListFilterViewControllerDelegate: class {
    func listFilterViewControllerCanSort() -> Bool
    func listFilterViewControllerDidSelect(_ filter : FilterSelected)
}

class ListFilterViewController: UIViewController {

    enum Sections: Int {
        case sectionFilter = 0, sectionSort, sectionCount
    }
    
    enum RowsOfFilter: Int {
        case rowOffice = 0, rowCategory, rowCount
    }
    
    enum RowsOfSort: Int {
        case rowSort = 0, rowCount
    }
    
    weak var delegate: ListFilterViewControllerDelegate?
    
    var filterSelected : FilterSelected!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = AppStrings.Title.filter.rawValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppStoryboards.segueIdentifierShowChooseFilter {
            if let vc = segue.destination as? ChooseFilterViewController {
                if let index = sender as? Int {
                    switch index {
                    case RowsOfFilter.rowOffice.rawValue:
                        vc.filterType = .office
                        vc.listSelect = filterSelected.offices
                        break
                    case RowsOfFilter.rowCategory.rawValue:
                        vc.filterType = .category
                        vc.listSelect = filterSelected.categories
                        break
                    default: break
                    }
                }
            }
        }
        else if segue.identifier == AppStoryboards.segueIdentifierShowChooseSort {
            if let vc = segue.destination as? ChooseSortViewController, let sort = self.filterSelected.sort {
                vc.sortSelected = sort
                vc.orderSelected = self.filterSelected.order
            }
        }
    }
    
    @IBAction func onTapCancel(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSubmit(sender: AnyObject) {
        self.delegate?.listFilterViewControllerDidSelect(filterSelected)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ListFilterViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.delegate?.listFilterViewControllerCanSort() == true) ? Sections.sectionCount.rawValue : Sections.sectionCount.rawValue - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.sectionFilter.rawValue:
            return RowsOfFilter.rowCount.rawValue
        case Sections.sectionSort.rawValue:
            return RowsOfSort.rowCount.rawValue
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemFilterCell", for: indexPath)
        
        var title = ""
        switch indexPath.section {
        case Sections.sectionFilter.rawValue:
            switch indexPath.row {
            case RowsOfFilter.rowOffice.rawValue:
                title = AppStrings.FilterViewController.office.rawValue
                break
            case RowsOfFilter.rowCategory.rawValue:
                title = AppStrings.FilterViewController.category.rawValue
                break
            default:
                break
            }
            break
        case Sections.sectionSort.rawValue:
            switch indexPath.row {
            case RowsOfSort.rowSort.rawValue:
                title = AppStrings.FilterViewController.sort.rawValue
                break
            default:
                break
            }
            break
        default: break
            
        }
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case Sections.sectionFilter.rawValue:
            self.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowChooseFilter, sender: indexPath.row)
            break
        case Sections.sectionSort.rawValue:
            self.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowChooseSort, sender: nil)
            break
        default: break
        }
        
    }
}
