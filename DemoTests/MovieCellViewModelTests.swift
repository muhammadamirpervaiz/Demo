//
//  MovieCellViewModelTests.swift
//  DemoTests
//
//  Created by Muhammad Amir Pervaiz on 5/31/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import XCTest
@testable import Demo

class MovieCellViewModelTests: XCTestCase {
    var movie: Movie!
    
    override func setUp() {
        movie = Movie.template
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testMovieCellViewModel() {
        
        let viewModel = MovieCellViewModel(title: movie.title, releaseDate: movie.release_date, overview: movie.overview, posterImage: movie.poster_path)
        
        XCTAssertEqual(viewModel.title, movie.title)
        XCTAssertEqual(viewModel.releaseDate, movie.release_date)
        XCTAssertEqual(viewModel.overview, movie.overview)
        XCTAssertEqual(viewModel.posterImage, movie.poster_path)
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        movie = nil
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
