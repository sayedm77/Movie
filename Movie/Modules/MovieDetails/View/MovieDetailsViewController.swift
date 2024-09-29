//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var genresNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    private var imageViewModel = MovieDetailsViewModel(with: nil)
    var movieDetailsViewModel: MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              view.backgroundColor = .systemGray6
              navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
              navigationController?.navigationBar.tintColor = UIColor.black
              
              configureUIElements()
    }
    
     func configureUIElements(){
         movieDetailsViewModel.fetchMovieDetails { movieDetails in
             if let posterPath = movieDetails.posterPath {
                 self.imageViewModel.downloadImage(posterPath: posterPath) { image in
                     DispatchQueue.main.async {
                         self.movieImageView.image = image
                         self.movieNameLabel.text = movieDetails.title
                         self.movieReleaseDateLabel.text = movieDetails.releaseDate
                         self.rateLabel.text = String(format: "%.1f", movieDetails.voteAverage)
                         self.runtimeLabel.text = "\(movieDetails.runtime) min"
                         self.revenueLabel.text = "Revenue: \(movieDetails.revenue)$"
                         self.overviewLabel.text = movieDetails.overview
                         self.genresNameLabel.text = self.movieDetailsViewModel.setGenres(from: movieDetails.genres)
                     }
                 }
             }
         }
     }


}
