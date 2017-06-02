//
//  ChooseSortViewController.swift
//  FBook
//
//  Created by admin on 6/1/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ChooseSortViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum Sections: Int {
        case sectionSort = 0, sectionOrder, sectionCount
    }
    
    var listSort: [Sort]?
    var listSortSelect = [Sort]()
    
    var listOrder = [Sort.sortDesc(),Sort.sortAsc()]
    var listOrderSelect = [Sort]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNoTitleBackButton()
        
        self.navigationItem.title = AppStrings.FilterViewController.sort.rawValue
        
        if let sort = listOrder.first {
            listOrderSelect.append(sort)
        }
        
        self.loadData()
    }
    
    private func loadData() {
        self.showLoading()
        let input = GetListSortInput()
        let apiService = FilterAPIService()
        apiService.getListSort(input) { [weak self] (output, error) in
            self?.hideLoading()
            
            if let output = output {
                self?.listSort = output.sorts
                self?.tableView.reloadData()
            }
            if let error = error {
                self?.showAlertError(error: error)
            }
        }
    }
}

extension ChooseSortViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = listSort?.count, count > 0 {
            return Sections.sectionCount.rawValue
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.sectionSort.rawValue:
            return listSort?.count ?? 0
        case Sections.sectionOrder.rawValue:
            return listOrder.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemChooseFilterCell", for: indexPath)
        
        switch indexPath.section {
        case Sections.sectionSort.rawValue:
            if let item = listSort?[indexPath.row] {
                cell.textLabel?.text = item.title
                if listSortSelect.contains(where: { $0.key == item.key }) {
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
            }
            break
        case Sections.sectionOrder.rawValue:
            let item = listOrder[indexPath.row]
            cell.textLabel?.text = item.title
            if listOrderSelect.contains(where: { $0.key == item.key }) {
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }
            break
        default: break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case Sections.sectionSort.rawValue:
            listSortSelect.removeAll()
            if let item = listSort?[indexPath.row] {
                listSortSelect.append(item)
            }
            break
        case Sections.sectionOrder.rawValue:
            listOrderSelect.removeAll()
            listOrderSelect.append(listOrder[indexPath.row])
            break
        default: break
        }
        tableView.reloadData()
    }
}
