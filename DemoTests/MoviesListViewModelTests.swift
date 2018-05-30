//
//  ViewModelTests.swift
//  DemoTests
//
//  Created by Muhammad Amir Pervaiz on 5/30/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import XCTest
@testable import Demo

class ViewModelTests: TestCase {
    
    var viewModel: MoviesListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MoviesListViewModel.init(environment)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testEmptySearchTextField() {
        viewModel.errorOccured = { (message) in
            XCTAssertEqual(message, "Enter movie name")
        }
        
        viewModel.fetchMoviesList("")
    }
    
    func testFetchMoviesListSuccess()  {
        
        (environment.sharedService as! MockService).mockResponse = self.mockSearchResponse()
        viewModel.fetchMoviesList("Batman")
        viewModel.reloadTableView = {
            XCTAssertEqual(self.viewModel.moviesList?.count, 20)
            XCTAssertTrue((self.viewModel.moviesList?.count)! > 0, "count is greater than zero")
        }
        
        (environment.sharedService as! MockService).fetchSuccessResponse()
        
    }
    
    func testSearchResultNotFound()  {
        
        (environment.sharedService as! MockService).mockResponse = self.mockSearchResponse()
        viewModel.fetchMoviesList("123456")
        
        viewModel.errorOccured = { message in
            XCTAssertEqual(message, "Error Occured. Please try again")
        }
        
        (environment.sharedService as! MockService).fetchFailureResponse()
    }
    
    func testFetchMoviesListFailure()  {
        
        (environment.sharedService as! MockService).mockResponse = self.mockSearchResponse()
        viewModel.fetchMoviesList("Batman")
       
        viewModel.errorOccured = { message in
            XCTAssertEqual(message, "No results found")
        }
        
        (environment.sharedService as! MockService).fetchEmptyResultArray()

    }
    
    func testPaginatedResponse() {
        
    }

    
   
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    override func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    override func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func mockSearchResponse() -> SearchResponse {
        
        let path = Bundle.main.path(forResource: "content", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return SearchResponse.from(jsonResult as! NSDictionary)!
    }
}
