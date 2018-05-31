//
//  Environment.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit

/**
 Class containing all global and Singleton variables that app has access to.
 */
class Environment: NSObject {

    var sharedService: ServiceType
    
    var suggesstionArray: [String]? {
        get{
            if let array = (UserDefaults.standard.value(forKey: "Suggesstions") as? [String]) {
                return array
            }
            else {
                return []
            }
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "Suggesstions")
            UserDefaults.standard.synchronize()
        }
    }

    init(sharedService: ServiceType = ServiceManager()) {
        self.sharedService = sharedService
    }
}
