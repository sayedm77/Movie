//
//  MovieServiceTests.swift
//  banquemisr.challenge05Tests
//
//  Created by sayed mansour on 29/09/2024.
//

import XCTest
@testable import banquemisr_challenge05

class MovieServiceTests: XCTestCase {
    
    func testGetMoviesListWithValidData() {
        MovieService.shared.getMoviesList(currentTab: "now_playing") { result in
            switch result {
            case .success(let movies):
                XCTAssertFalse(movies.isEmpty)
            case .failure(let errorMessage):
                XCTFail("Expected success, but got failure with error: \(errorMessage)")
            }
        }
    }
    
    
    
    func testGetMovieDetailsWithValidData(){
        MovieService.shared.getMovieDetails(for: 12345) { result in
            switch result{
            case .success(let movieDetails):
                XCTAssertNotNil(movieDetails)
            case .failure(let errorMessage):
                XCTFail("Expected success, but got failure with error: \(errorMessage)")
            }
        }
    }
    
    
    func testGetMovieDetailsWithInvalidMovieID() {
        MovieService.shared.getMovieDetails(for: -1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to invalid movie ID")
            case .failure(let errorMessage):
                XCTAssertNotNil(errorMessage, "Expected error should not be nil")
            }
        }
    }
}
