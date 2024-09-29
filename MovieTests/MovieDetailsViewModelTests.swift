//
//  MovieDetailsViewModelTests.swift
//  banquemisr.challenge05Tests
//
//  Created by sayed mansour on 29/09/2024.

import XCTest
@testable import banquemisr_challenge05

    class MovieDetailsViewModelTests: XCTestCase {
        
        var movieDetailsViewModel: MovieDetailsViewModel!
        var mockMovieService: MockMovieService!
        
        override func setUpWithError() throws {
            movieDetailsViewModel = MovieDetailsViewModel(with: 1 )
            mockMovieService = MockMovieService()
            MovieService.shared = mockMovieService
        }
        
        override func tearDownWithError() throws {
            movieDetailsViewModel = nil
            mockMovieService = nil
        }
        
        func testFetchMovieDetailsSuccess() {
            let expectedMovieDetails = MovieDetails(id: 1, title: "Test Movie", releaseDate: "2022", genres: [], overview: "Test overview", posterPath:  "testPosterPath", runtime: 120, voteAverage: 7.5, revenue: 1000000)
            mockMovieService.result = .success(expectedMovieDetails)
            
            var fetchedMovieDetails: MovieDetails?
            movieDetailsViewModel.fetchMovieDetails { movieDetails in
                fetchedMovieDetails = movieDetails
            }
            XCTAssertNotNil(fetchedMovieDetails)
            XCTAssertEqual(fetchedMovieDetails?.title, expectedMovieDetails.title)
            XCTAssertEqual(fetchedMovieDetails?.releaseDate, expectedMovieDetails.releaseDate)
            XCTAssertEqual(fetchedMovieDetails?.overview, expectedMovieDetails.overview)
            XCTAssertEqual(fetchedMovieDetails?.posterPath, expectedMovieDetails.posterPath)
            XCTAssertEqual(fetchedMovieDetails?.runtime, expectedMovieDetails.runtime)
            XCTAssertEqual(fetchedMovieDetails?.voteAverage, expectedMovieDetails.voteAverage)
            XCTAssertEqual(fetchedMovieDetails?.revenue, expectedMovieDetails.revenue)
        }
        
        
        func testSetGenres() {
            let genres: [Genre] = [
                Genre(id: 1, name: "Action"),
                Genre(id: 2, name: "Adventure"),
                Genre(id: 3, name: "Drama")
            ]
            
            let formattedGenres = movieDetailsViewModel.setGenres(from: genres)
            
            XCTAssertEqual(formattedGenres, "Action, Adventure, Drama")
        }
        
        class MockMovieService: MovieService {
            var result: Result<MovieDetails, ErrorMessage>?
            
            override func getMovieDetails(for movieID: Int, completion: @escaping (Result<MovieDetails, ErrorMessage>) -> Void) {
                if let result = result {
                    completion(result)
                }
            }
        }
    }

