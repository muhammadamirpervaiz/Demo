//
//  Route.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit
import Alamofire

enum Route {
    
    case searchMovies(query: String, pagination: Int)
    
    var routeProperties: (method: HTTPMethod, url: String, params: [String: Any]) {
        switch self {
        case .searchMovies(let query, let pagination):
            return (.get, "/search/movie?api_key=\(API_KEY)&query=\(query)&page=\(pagination)", [:])
        }
    }
}

