//
//  MoviesListViewModel.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit

class MoviesListViewModel: NSObject {

    let apiClient: ServiceType!
    var moviesList: [Movie]?
    var suggesstionList: [String]?
    
    init(_ environment: Environment) {
        apiClient = environment.sharedService
    }
    
    /// Output Variables and Methods
    var moviesArray: [Movie]?
    var reloadTableView: (() -> ())!
    
    func fetchMoviesList(_ queury: String) {
        apiClient.searchMovie(queury, page: 1) { [unowned self] (success, response, error) in
            if success {
                self.moviesList = response?.results
                self.reloadTableView()
            }
            else {
                
            }
        }
    }
    
    func count() -> Int {
        if let count = moviesList?.count {
            return count
        }
        return 0
    }
    
    func getObjectAt(_ index: Int) -> Movie {
        return self.moviesList![index]
    }
    
}
