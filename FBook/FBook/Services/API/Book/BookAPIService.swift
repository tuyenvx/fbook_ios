//
//  BookAPIService.swift
//  FBook
//
//  Created by admin on 5/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BookAPIService: APIService {
    func getHomePage<T:GetHomePageOutput>(_ input: GetHomePageInput, completion:@escaping (_ value: T?,_ error: Error?) -> Void) {
        return self.request(input, completion: completion)
    }
    
    func getListBookOfSection<T:GetListBookOfSectionOutput>(_ input: GetListBookOfSectionInput, completion:@escaping (_ value: T?,_ error: Error?) -> Void) {
        return self.request(input, completion: completion)
    }
}
