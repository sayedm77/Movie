//
//  MovieDetails.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import Foundation
struct MovieDetails: Codable{
    let id: Int
    let title: String
    let releaseDate: String
    let genres: [Genre]
    let overview: String
    let posterPath: String?
    let runtime: Int
    let voteAverage: Double
    let revenue: Int
}


struct Genre: Codable{
    let id: Int
    let name: String
}
