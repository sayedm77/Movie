//
//  MovieService.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import UIKit


class MovieService{
    
    static var shared = MovieService()
    
    init() {}
    
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "2d673c25b80f87709bd88303aaf49718"
    private let imageUrlHeader = "https://image.tmdb.org/t/p/"
    private let posterSize = "w500"
    
    
    func getMoviesList(currentTab: String,completion: @escaping (Result<[Movie], ErrorMessage>) -> Void){
        
        let urlString = baseUrl + "\(currentTab)?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let movies = self.parseJSONforMoviesList(from: data) else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(movies))
        }
        task.resume()
    }
    
    func downloadImage(from posterPath: String, completion: @escaping (Result<UIImage?, Error>) -> Void){
        
        guard let url = URL(string: imageUrlHeader + posterSize + posterPath) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self else { return }
            
            
            if let _ = error{ return }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{ return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            completion(.success(image))
            
        }
        task.resume()
    }
    
    func getMovieDetails(for movieId: Int, completion: @escaping (Result<MovieDetails,ErrorMessage>) -> Void){
        guard let url = URL(string: baseUrl + "\(movieId)?api_key=" + apiKey) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let movieDetails = self.parseJSONForMovieDetails(from: data) else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(movieDetails))
        }
        task.resume()
    }
    
    private func parseJSONforMoviesList(from data: Data) -> [Movie]?{
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(MoviesList.self, from: data)
            let moviesList = decodedData.results
            return moviesList
        } catch{
            return nil
        }
    }
    private func parseJSONForMovieDetails(from data: Data) -> MovieDetails?{
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(MovieDetails.self, from: data)
            let moviesList = decodedData
            return moviesList
        } catch{
            return nil
        }
    }
}
