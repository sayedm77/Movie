//
//  ErrorMessage.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import Foundation

enum ErrorMessage: String, Error{
    
    case invalidRequest = "Invalid request. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again."
}
