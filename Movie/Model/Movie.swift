//
//  Movie.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import Foundation



struct MoviesList: Codable{
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterPath: String?
}
