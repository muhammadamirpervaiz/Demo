//
//  MockService.swift
//  DemoTests
//
//  Created by Muhammad Amir Pervaiz on 5/30/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit
@testable import Demo

public class MockService: ServiceType {
    
    var mockResponse: SearchResponse? = nil
    var completeClosure: ((Bool, SearchResponse?, Error?) -> Void)!
    
    public func searchMovie(_ query: String, page: Int, completion: @escaping ((Bool, SearchResponse?, Error?) -> Void)) {
        completeClosure = completion
    }
    
    func fetchSuccessResponse() {
        completeClosure( true, mockResponse, nil )
    }
    
    func fetchFailureResponse() {
        let error = NSError(domain:"com.app.demo", code: 500, userInfo: nil)
        completeClosure( false, SearchResponse.template, error)
    }
    
    func fetchEmptyResultArray() {
        completeClosure( true, SearchResponse.template, nil)
    }
}
