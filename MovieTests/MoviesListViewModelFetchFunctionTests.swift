//
//  MoviesListViewModelFetchFunctionTests.swift
//  banquemisr.challenge05Tests
//
//  Created by sayed mansour on 29/09/2024.
//

import XCTest
@testable import banquemisr_challenge05

class MoviesListViewModelFetchFunctionTests: XCTestCase {
    
    var moviesListViewModel: MoviesListViewModel!
    var mockMovieService: MockMovieService!
    
    override func setUpWithError() throws {
        moviesListViewModel = MoviesListViewModel()
        mockMovieService = MockMovieService()
        MovieService.shared = mockMovieService
    }
    
    override func tearDownWithError() throws {
        moviesListViewModel = nil
        mockMovieService = nil
    }
    
    func testFetchMoviesList_Success() {
        mockMovieService.result = .success([MockData.movie1, MockData.movie2])
        moviesListViewModel.fetchMoviesList(currentTab: "now_playing")
        XCTAssertEqual(moviesListViewModel.numberOfMovies(), 2)
    }
    
    func testFetchMoviesList_Failure() {
        mockMovieService.result = .failure(.invalidRequest)
        moviesListViewModel.fetchMoviesList(currentTab: "now_playing")
        
        XCTAssertEqual(moviesListViewModel.numberOfMovies(), 0, "Number of movies should be 0")
    }
    
    class MockMovieService: MovieService {
        var result: Result<[Movie], ErrorMessage>?
        
        override init() {
            super.init()
        }
        
        override func getMoviesList(currentTab: String, completion: @escaping (Result<[Movie], ErrorMessage>) -> Void) {
            if let result = result {
                completion(result)
            }
        }
    }
    struct MockData {
        static let movie1 = Movie(id: 1, title: "Movie 1", releaseDate: "2000", posterPath: nil)
        static let movie2 = Movie(id: 2, title: "Movie 2", releaseDate: "2001", posterPath: nil)
    }
}
