//
//  Constant.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit

let BASE_URL = "https://api.themoviedb.org/3"
let API_KEY = "2696829a81b1b5827d515ff121700838"


func getEnvironment() -> Environment {
    let appdelegate = (UIApplication.shared.delegate as! AppDelegate)
    return appdelegate.environment
}
