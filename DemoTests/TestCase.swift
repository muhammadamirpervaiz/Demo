//
//  TestCase.swift
//  DemoTests
//
//  Created by Muhammad Amir Pervaiz on 5/30/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import XCTest
@testable import Demo
class TestCase: XCTestCase {
    
    var environment: Environment!
    var mockService: MockService = MockService()
    
    override func setUp() {
        
        environment = Environment(sharedService: mockService)
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        environment = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
