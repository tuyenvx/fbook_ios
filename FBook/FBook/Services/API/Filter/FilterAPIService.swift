//
//  FilterAPIService.swift
//  FBook
//
//  Created by admin on 5/31/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class FilterAPIService: APIService {
    func getListOffice<T:GetListOfficeOutput>(_ input: GetListOfficeInput, completion:@escaping (_ value: T?,_ error: Error?) -> Void) {
        return self.request(input, completion: completion)
    }
    
    func getListCategory<T:GetListCategoryOutput>(_ input: GetListCategoryInput, completion:@escaping (_ value: T?,_ error: Error?) -> Void) {
        return self.request(input, completion: completion)
    }
    
    func getListSort<T:GetListSortOutput>(_ input: GetListSortInput, completion:@escaping (_ value: T?,_ error: Error?) -> Void) {
        return self.request(input, completion: completion)
    }
}
