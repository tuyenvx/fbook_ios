//
//  Strings.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct AlertVC {
    //Titles
    enum AlertTitle: String {
        case title = "Alert"
        case error = "Error"
        case ok = "OK"
        case cancel = "Cancel"
        
        var description: String {
            return self.rawValue
        }
    }
    
    //Messages
    struct AlertMessage {
        
        //login
        static let  emailEmpty = "Email is empty"
        static let  passEmpty = "Password is empty"
    }
}
