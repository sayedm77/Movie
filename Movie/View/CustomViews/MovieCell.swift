//
//  MovieCell.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseID = "MovieCell"
    
    var imageViewModel = MoviesListViewModel()
    
    let movieImageView = customMovieImageView(frame: .zero)
    let movieNameLabel = customTitleLabel(textAlignment: .center, fontSize: 14)
    let movieRelaseDateLabel = customSecondaryLabel(fontSize: 12,textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMovieImageView()
        configureMovieNameLabel()
        configureMovieReleaseDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with movie: Movie){
        if let posterPath = movie.posterPath {
            imageViewModel.getMovieImage(posterPath: posterPath) { image in
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            }
        }
        movieNameLabel.text = movie.title
        movieRelaseDateLabel.text = movie.releaseDate
    }
    
    
    private func configureMovieImageView() {
        addSubview(movieImageView)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            movieImageView.heightAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    private func configureMovieNameLabel() {
        addSubview(movieNameLabel)
        
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5),
            movieNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    private func configureMovieReleaseDateLabel() {
        addSubview(movieRelaseDateLabel)
    
        NSLayoutConstraint.activate([
            movieRelaseDateLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 2),
            movieRelaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            movieRelaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            movieRelaseDateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
