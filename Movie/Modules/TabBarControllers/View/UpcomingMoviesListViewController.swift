//
//  UpcomingMoviesListViewController.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import UIKit

class UpcomingMoviesListViewController: UIViewController, UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var moviesListViewModel = MoviesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        moviesListViewModel.fetchMoviesList(currentTab: "upcoming")
        moviesListViewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        moviesListViewModel.showError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.presentErrorAlert(message: errorMessage)
            }
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
    }
    
}
//MARK: - UICollectionViewDataSource
extension UpcomingMoviesListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesListViewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = moviesListViewModel.movie(at: indexPath.item)
        cell.set(with: movie)
        
        return cell
    }
}
//MARK: - UIcollectionViewDelegate
//extension UpcomingMoviesListViewController: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let movieId = moviesListViewModel.didSelectMovie(at: indexPath.item) else { return }
//        
//        let movieDetailsViewModel = MovieDetailsViewModel(with: movieId)
//        let movieDetailsVC = MovieDetailsViewController()
//        movieDetailsVC.movieDetailsViewModel = movieDetailsViewModel
//        movieDetailsVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(movieDetailsVC, animated: true)
//    }
//}

