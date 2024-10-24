//
//  MainVC.swift
//  Music Search App
//
//  Created by Bakhtovar on 22/10/24.
//

import UIKit
import Foundation

class MainVC: UIViewController {
    
    // MARK: - properties
    
    private let viewModel = MusicSearchViewModel()
    
    // MARK: - views
    
    private lazy var searchController: UISearchController = {
        let resultOfSearchVC = MusicSearchVC()
        let controller = UISearchController(searchResultsController: resultOfSearchVC)
        controller.searchBar.searchBarStyle = .default
        controller.searchBar.placeholder = "Search Media"
        controller.searchBar.keyboardAppearance = .default
        controller.searchBar.tintColor = .blue
        controller.searchBar.barTintColor = .systemBrown
        controller.showsSearchResultsController = true
        controller.searchBar.barStyle = .default
        return controller
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "dancingLogo")
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.text = "Immerse to music"
        return label
    }()
   
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigation()
        
        addSubViews()
        applyConstraints()
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    // MARK: - private
    
    private func addSubViews() {
        view.addSubview(iconImageView)
        view.addSubview(descriptionLabel)
    }
    
    private func applyConstraints() {
        [
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 300),
            iconImageView.heightAnchor.constraint(equalToConstant: 300),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ].forEach { $0.isActive = true }
    }
    
    private func setupNavigation() {
        title = "Music Search"
        navigationItem.searchController = self.searchController
        self.searchController.searchResultsUpdater = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func navigateToDetail(with mediaItem: MediaItem) {
        let aboutMediaVC = AboutMediaVC(mediaItem: mediaItem)
        navigationController?.pushViewController(aboutMediaVC, animated: true)
    }
    
    private func displaySearchHistorySuggestions(for searchController: UISearchController) {
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        let history = viewModel.getSearchHistory()
        searchResultVC.updateSuggestions(history)
    }
    
    // MARK: - objc
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - extensions

extension MainVC: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        
        if text.isEmpty {
            displaySearchHistorySuggestions(for: searchController)
        } else {
            searchResultVC.searchText = text
        }
        
        searchResultVC.onMediaItemSelected = { [weak self] mediaItem in
            self?.navigateToDetail(with: mediaItem)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // At the beginning of editing, we show the search history
        displaySearchHistorySuggestions(for: searchController)
    }
    
    // enter handling
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        
        searchResultVC.searchText = searchBar.text ?? ""
        searchResultVC.updateSearchResults()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        searchResultVC.searchText = ""
    }
}
