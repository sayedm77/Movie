//
//  MoviesListViewModelTests.swift
//  banquemisr.challenge05Tests
//
//  Created by sayed mansour on 29/09/2024.
//


import XCTest
@testable import banquemisr_challenge05

class MoviesListViewModelTests: XCTestCase {
    
    var moviesListViewModel: MoviesListViewModel!
    var movies: [Movie]!
    
    override func setUpWithError() throws {
        let movie1 = Movie(id: 1, title: "Movie 1", releaseDate: "2000", posterPath: nil)
        let movie2 = Movie(id: 2, title: "Movie 2", releaseDate: "2001", posterPath: nil)
        let movie3 = Movie(id: 3, title: "Movie 3", releaseDate: "2002", posterPath: nil)
        movies = [movie1, movie2, movie3]
        moviesListViewModel = MoviesListViewModel()
        moviesListViewModel.movies = movies
    }
    
    override func tearDownWithError() throws {
        moviesListViewModel = nil
    }
    
    func testNumberOfMovies() {
        let numberOfMovies = moviesListViewModel.numberOfMovies()
        XCTAssertEqual(numberOfMovies, 3)
    }
    
    func testMovieAtIndex() {
        let movie = moviesListViewModel.movie(at: 1)
        
        XCTAssertEqual(movie.id, 2)
        XCTAssertEqual(movie.title, "Movie 2")
        XCTAssertEqual(movie.releaseDate, "2001")
        XCTAssertEqual(movie.posterPath, nil)
    }
    
    
    func testDidSelectMovieAtIndex_ValidIndex() {
        let movieID = moviesListViewModel.didSelectMovie(at: 0)
        XCTAssertEqual(movieID, 1)
    }
    
    func testDidSelectMovieAtIndex_InvalidIndex() {
        let movieID = moviesListViewModel.didSelectMovie(at: 5)
        XCTAssertNil(movieID)
    }
    
}



