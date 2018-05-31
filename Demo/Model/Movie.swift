//
//  Movie.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit
import Mapper
// Conform to the Mappable protocol
public struct Movie {
    
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let vote_average: Float?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let original_language: String?
    let original_title: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
}

extension Movie : Mappable {
    public init(map: Mapper) throws {
        
        vote_count = map.optionalFrom("vote_count")
        id = map.optionalFrom("id")
        video = map.optionalFrom("video")
        vote_average = map.optionalFrom("vote_average")
        title = map.optionalFrom("title")
        popularity = map.optionalFrom("popularity")
        poster_path = map.optionalFrom("poster_path")
        original_language = map.optionalFrom("original_language")
        original_title = map.optionalFrom("original_title")
        genre_ids = map.optionalFrom("genre_ids")
        backdrop_path = map.optionalFrom("backdrop_path")
        adult = map.optionalFrom("adult")
        overview = map.optionalFrom("overview")
        release_date = map.optionalFrom("release_date")
    }
}

extension Movie {
    internal static let template =  Movie(vote_count: 1, id: 2, video: true, vote_average: 2.3, title: "Batman", popularity: 3.55, poster_path: "https://api.themoviedb.org", original_language: "en", original_title: "Batman", genre_ids: [], backdrop_path: "https://api.themoviedb.org", adult: false, overview: "Awesome", release_date: "2017-10-10")
}
