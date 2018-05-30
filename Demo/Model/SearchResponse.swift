//
//  SearchResponse.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit

import Mapper
// Conform to the Mappable protocol
public struct SearchResponse {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Movie]?
}

extension SearchResponse : Mappable {
    public init(map: Mapper) throws {
        page = map.optionalFrom("page")
        total_results = map.optionalFrom("total_results")
        total_pages = map.optionalFrom("total_pages")
        results = map.optionalFrom("results")
    }
}

extension SearchResponse {
    internal static let template =  SearchResponse(page: 1, total_results: 0, total_pages: 0, results: [])
}
