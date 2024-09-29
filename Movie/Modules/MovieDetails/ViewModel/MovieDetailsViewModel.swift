//
//  MovieDetailsViewModel.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//


import UIKit


class MovieDetailsViewModel{
    
    private let movieID: Int!
    private var movie: MovieDetails!
    
    init(with movieID: Int?) {
        self.movieID = movieID
    }
    
    func fetchMovieDetails(completion: @escaping (MovieDetails) -> Void){
        MovieService.shared.getMovieDetails(for: movieID) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
                
            case .success(let movie):
                self.movie = MovieDetails(id: movie.id, title: movie.title, releaseDate: movie.releaseDate, genres: movie.genres, overview: movie.overview, posterPath: movie.posterPath, runtime: movie.runtime, voteAverage: movie.voteAverage, revenue: movie.revenue)
                completion(self.movie)
            case .failure(let error):
                print("error fetching moviesDetails \(error)")
            }
        }
    }
    
    func downloadImage(posterPath: String, completion: @escaping (UIImage?) -> Void ){
        MovieService.shared.downloadImage(from: posterPath) { [weak self] result in
            guard let _ = self else { return  }
            
            switch result{
            case .success(let image):
                completion(image)
                
            case .failure(let error):
                print("error downloading image \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func setGenres(from genres: [Genre]) -> String {
        let genreNames = genres.map { $0.name }
        let concatenatedNames = genreNames.joined(separator: ", ")
        return concatenatedNames
    }
    
    
}
