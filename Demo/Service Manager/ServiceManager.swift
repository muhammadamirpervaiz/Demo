//
//  ServiceManager.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit
import Alamofire

typealias Response = (Any, Error)

public struct ServiceManager: ServiceType {
    
    public func searchMovie(_ query: String, page: Int, completion: @escaping ((Bool, SearchResponse?, Error?) -> Void)) {
        
        let route: Route = .searchMovies(query: query, pagination: page)
        
        Alamofire.request(BASE_URL + route.routeProperties.url, method: route.routeProperties.method).responseJSON { (response) in
            
            switch response.result {
            case .success:
                if response.response?.statusCode == 200  {
                    completion(true, SearchResponse.from(response.result.value as! NSDictionary), nil)
                }
                else {
                    let error = NSError.init(domain: "com.demo.ios", code: (response.response?.statusCode)!, userInfo: nil)
                    completion(true, nil, error)
                }
            case .failure(let error):
                completion(true, nil, error)
                
            }
        }
    }
    
}
