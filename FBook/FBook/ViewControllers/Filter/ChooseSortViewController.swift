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
    
    enum FilterType {
        case office
        case category
    }
    
    var filterType : FilterType = .office
    
    var list: [Any]?
    var listSelect = [Any]()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNoTitleBackButton()
        
        switch filterType {
        case .office:
            self.navigationItem.title = AppStrings.FilterViewController.office.rawValue
        case .category:
            self.navigationItem.title = AppStrings.FilterViewController.category.rawValue
        }
        
        self.loadData()
    }
    
    private func loadData() {
        switch filterType {
        case .office:
            self.loadDataOffice()
        case .category:
            self.loadDataCategory()
        }
    }
    
    private func loadDataOffice() {
        self.showLoading()
        let input = GetListOfficeInput()
        let apiService = FilterAPIService()
        apiService.getListOffice(input) { [weak self] (output, error) in
            self?.hideLoading()
            
            if let output = output {
                self?.list = output.offices
                self?.tableView.reloadData()
            }
            if let error = error {
                self?.showAlertError(error: error)
            }
        }
    }
    
    private func loadDataCategory() {
        self.showLoading()
        let input = GetListCategoryInput()
        let apiService = FilterAPIService()
        apiService.getListCategory(input) { [weak self] (output, error) in
            self?.hideLoading()
            
            if let output = output {
                self?.list = output.categories
                self?.tableView.reloadData()
            }
            if let error = error {
                self?.showAlertError(error: error)
            }
        }
    }
}

extension ChooseSortViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemChooseFilterCell", for: indexPath)
        switch filterType {
        case .office:
            if let item = list?[indexPath.row] as? Office {
                cell.textLabel?.text = item.name
                if listSelect.contains(where: {($0 as! Office).id == item.id}) {
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
            }
        case .category:
            if let item = list?[indexPath.row] as? Category {
                cell.textLabel?.text = item.name
                if listSelect.contains(where: {($0 as! Category).id == item.id}) {
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = list?[indexPath.row] as? Office, let index = listSelect.index(where: {($0 as! Office).id == item.id}) {
            listSelect.remove(at: index)
        }
        else if let item = list?[indexPath.row] as? Category, let index = listSelect.index(where: {($0 as! Category).id == item.id}) {
            listSelect.remove(at: index)
        }
        else if let item = list?[indexPath.row] {
            listSelect.append(item)
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
