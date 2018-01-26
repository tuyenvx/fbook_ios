//
//  DoLoginApiService.swift
//  FBook
//
//  Created by TuyenVX on 1/26/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation

class DoLoginApiService: APIService {
    func doLogin<T: DoLoginOutput>(_ input: DoLoginInput, completion:@escaping (_ value: T?,_ error: Error?) -> Void) {
        return self.request(input, completion: completion)
    }
}
