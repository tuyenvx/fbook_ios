//
//  APIService.swift
//  FBook
//
//  Created by admin on 5/24/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class APIService {
    func request<T: Mappable>(_ input: APIInputBase, completion:@escaping (_ value: T?,_ error: Error?) -> Void) {
        let headers = input.headers
        
        if input.isTokenRequired {
            
        }
        
        Alamofire.request(input.urlString,
                          method: input.requestType,
                          parameters: input.parameters,
                          encoding: input.encoding,
                          headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == ResponseStatusCode.success.rawValue {
                            guard let message = ResponseMessage(value: value) else {
                                completion(nil, ResponseError.invalidData)
                                return
                            }
                            
                            if message.status == true, let data = value as? [String: Any], let t = T(JSON: data) {
                                completion(t, nil)
                            }
                            else {
                                completion(nil, ResponseError.responseMessage(message: message))
                            }
                        }
                        else {
                            completion(nil, ResponseError.validate(statusCode: statusCode))
                        }
                    }
                    else {
                        completion(nil, ResponseError.noStatusCode)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
