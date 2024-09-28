//
//  MoviesListViewModel.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import UIKit


class MoviesListViewModel{
    
    var movies: [Movie] = []
    private var image = UIImage()
    
    var reloadCollectionView: (() -> Void)?
    var showError: ((String) -> Void)?
    
    func fetchMoviesList(currentTab: String){
        MovieService.shared.getMoviesList(currentTab: currentTab) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let movies):
                self.movies = movies
                self.reloadCollectionView?()
                
            case .failure(let error):
                print("error fetching movieslist \(error.localizedDescription)")
                self.showError?(ErrorMessage.invalidRequest.rawValue)
            }
        }
    }
    
    func getMovieImage(posterPath: String, completion: @escaping (UIImage?) -> Void ){
        MovieService.shared.downloadImage(from: posterPath) { [weak self] result in
            guard let self = self else { return  }
            
            switch result{
            case .success(let image):
                completion(image)
                
            case .failure(let error):
                print("error downloading image \(error.localizedDescription)")
                self.showError?(ErrorMessage.invalidResponse.rawValue)
                completion(nil)
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> Movie{
        return movies[index]
    }
    
    func didSelectMovie(at index: Int) -> Int? {
        guard index >= 0 && index < movies.count else {
            return nil
        }
        return movies[index].id
    }
}
