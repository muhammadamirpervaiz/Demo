//
//  ServiceType.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit

public protocol ServiceType {

    func searchMovie(_ query: String, page: Int, completion: @escaping ((Bool, SearchResponse?, Error?) -> Void))
}

