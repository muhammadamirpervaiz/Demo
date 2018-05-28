//
//  Environment.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit

class Environment: NSObject {

    var sharedService: ServiceType
    
    var suggesstionArray: [String] {
        get{
            return UserDefaults.standard.value(forKey: "Suggesstions") as! [String]
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "Suggesstions")
            UserDefaults.standard.synchronize()
        }
    }
    
    override init() {
        self.sharedService = ServiceManager()
    }
}
