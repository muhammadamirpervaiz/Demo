//
//  MoviesListViewModel.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit
enum cellType {
    case Movies
    case Suggesstions
}

class MoviesListViewModel: NSObject {

    let apiClient: ServiceType!
    var moviesList: [Movie]?
    var suggesstionList: [String]? 
    var pageCount: Int = 1
    var totalPages: Int = 0
    var isLoading: Bool = false
    var cellType: cellType = .Suggesstions
    var appEnvironment: Environment!
    var errorOccured: ((String) -> ())!

    init(_ environment: Environment) {
        appEnvironment = environment
        apiClient = environment.sharedService
        suggesstionList = environment.suggesstionArray
    }
    
    var reloadTableView: (() -> ())!
    var updateTableView: (([IndexPath]) -> ())!

    func fetchMoviesList(_ query: String) {
        
        if (query.count == 0) {
            self.errorOccured("Enter movie name")
            return
        }

        apiClient.searchMovie(query, page: pageCount) { [unowned self] (success, response, error) in
            if success {
                if (response?.results?.count)! > 0 {
                    if (self.pageCount > 1) {
                        self.totalPages = (response?.total_pages)!
                        var indexArray: [IndexPath] = []
                        if let array = response?.results {
                            for i in 0..<array.count {
                                let index = IndexPath.init(row:(self.moviesList?.count)! + i , section: 0)
                                indexArray.append(index)
                            }
                            self.moviesList = self.moviesList! + (response?.results)!
                            self.updateTableView(indexArray)
                        }
                    }
                    else {
                        self.totalPages = (response?.total_pages)!
                        self.moviesList = response?.results
                        
                        self.addQueryInSuggesstions(query)
                        self.reloadTableView()
                    }
                    self.isLoading = false
                }
                else {
                    self.errorOccured("No results found")
                }
            }
            else {
                self.errorOccured("Error Occured. Please try again")
            }
        }
    }
    
    func loadPaginatedResponseWith(_ query: String) {
        if (pageCount < totalPages) {
            pageCount = pageCount + 1
            fetchMoviesList(query)
        }
    }
    
    func count() -> Int {
        if cellType == .Movies {
            if let count = moviesList?.count {
                return count
            }
            return 0
        }
        else {
            if let count = suggesstionList?.count {
                return count
            }
            return 0
        }
    }
    
    func addQueryInSuggesstions(_ query: String) {
        if (self.suggesstionList?.contains(query))! {
            let index = self.suggesstionList?.index(of: query)
            self.suggesstionList?.remove(at: index!)
            self.suggesstionList?.insert(query, at: 0)
        }
        else {
            self.suggesstionList?.insert(query, at: 0)
        }
        
        if ((self.suggesstionList?.count)! > 10) {
            self.suggesstionList?.removeLast()
        }
        
        self.appEnvironment.suggesstionArray = self.suggesstionList;
    }
    
    func resetPagination()  {
        self.pageCount = 1
    }
    
    func getObjectAt(_ index: Int) -> Movie {
        return self.moviesList![index]
    }
    
    func getSuggesstionAt(_ index: Int) -> String {
        return self.suggesstionList![index]
    }
    
    func getLoadingStatus() -> Bool {
        return isLoading
    }
    
    func setLoadingStatus(_ loading: Bool) {
        self.isLoading = loading
    }
    
    func setCellType(_ type: cellType)  {
        self.cellType = type
        if self.cellType == .Suggesstions {
            self.moviesList = nil
        }
    }
    
    func getCellType() -> cellType  {
        return self.cellType
    }
}
