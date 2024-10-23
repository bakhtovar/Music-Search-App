//
//  MainVC.swift
//  Music Search App
//
//  Created by Bakhtovar on 22/10/24.
//

import Foundation
import UIKit

//class MainVC: UIViewController {
//
//    // - MARK: init
//
//    // - MARK: views
//
//    private lazy var searchController: UISearchController = {
//        let resultOfSearchVC = MusicSearchVC()
//        let controller = UISearchController(
//            searchResultsController: resultOfSearchVC
//        )
//        controller.searchBar.searchBarStyle = .default
//        controller.searchBar.placeholder = "Search"
//        controller.searchBar.keyboardAppearance = .default
//        controller.searchBar.tintColor = .blue
//        controller.searchBar.barTintColor = .systemBrown
//        controller.searchBar.setValue("Cancel", forKey: "cancelButton")
//        controller.showsSearchResultsController = true
//        controller.searchBar.barStyle = .default
//        return controller
//    }()
//
//    // - MARK: override
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .red
////        searchController.delegate = self
////        searchController.searchBar.delegate = self
////        setupNavigation()
//    }
//
//
//    // - MARK: private
//
//    private func setupNavigation() {
//        title = "Music Search"
//        navigationItem.searchController = self.searchController
//        self.searchController.searchResultsUpdater = self
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//
//        // Create the "Close" button
//        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
//        closeButton.tintColor = .black
//        navigationItem.rightBarButtonItem = closeButton
//    }
//
//    // - MARK: @objc
//
//    @objc private func closeButtonTapped() {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}
//
//extension MainVC : UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate  {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
//
//
//        searchResultVC.searchText = text
//    }
//}

import UIKit
import Foundation
//
//class MainVC: UIViewController {
//    
//    private let viewModel = MusicSearchViewModel()
//    
//    // Search controller to handle search bar and results
//    private lazy var searchController: UISearchController = {
//        let resultOfSearchVC = MusicSearchVC()
//        let controller = UISearchController(searchResultsController: resultOfSearchVC)
//        controller.searchBar.searchBarStyle = .default
//        controller.searchBar.placeholder = "Search Music"
//        controller.searchBar.keyboardAppearance = .default
//        controller.searchBar.tintColor = .blue
//        controller.searchBar.barTintColor = .systemBrown
//        controller.showsSearchResultsController = true
//        controller.searchBar.barStyle = .default
//        return controller
//    }()
//    
//    private let iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "dancingLogo")
//        return imageView
//    }()
//
//    private let descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.textColor = .black
//        label.text = "Immerse to music"
//        return label
//    }()
//   
//    // MARK: - Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        setupNavigation()
//        
//        addSubViews()
//        applyConstraints()
//        
//        searchController.delegate = self
//        searchController.searchBar.delegate = self
//    }
//    
//    // MARK: - Private Methods
//    
//    private func addSubViews() {
//        view.addSubview(iconImageView)
//        view.addSubview(descriptionLabel)
//    }
//    
//    private func applyConstraints() {
//        [
//            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            iconImageView.widthAnchor.constraint(equalToConstant: 300),
//            iconImageView.heightAnchor.constraint(equalToConstant: 300),
//            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            descriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
//            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//            
//        ].forEach { $0.isActive = true }
//    }
//    
//    private func setupNavigation() {
//        title = "Music Search"
//        navigationItem.searchController = self.searchController
//        self.searchController.searchResultsUpdater = self
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//        
//        // Create the "Close" button
////        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
////        closeButton.tintColor = .black
////        navigationItem.rightBarButtonItem = closeButton
//    }
//    
//    // Display search history when the user taps into the search bar
//    private func displaySearchHistorySuggestions(for searchController: UISearchController) {
//        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
//        let history = viewModel.getSearchHistory() // Retrieve search history from ViewModel
//        searchResultVC.updateSuggestions(history) // Pass the history to MusicSearchVC to display
//    }
//    
//    // MARK: - Actions
//    
//    @objc private func closeButtonTapped() {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
//
//// MARK: - UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate
//
//extension MainVC: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
//        
//        // If search bar is empty, display history suggestions
//        if text.isEmpty {
//            displaySearchHistorySuggestions(for: searchController)
//        } else {
//            // Update search text in search results view controller
//            searchResultVC.searchText = text
//        }
//    }
//    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        // When the user taps on the search bar, display the history
//        displaySearchHistorySuggestions(for: searchController)
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        // If the cancel button is clicked, clear the search text
//        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
//        searchResultVC.searchText = ""
//    }
//}

class MainVC: UIViewController {
    
    private let viewModel = MusicSearchViewModel()
    
    // Search controller to handle search bar and results
    private lazy var searchController: UISearchController = {
        let resultOfSearchVC = MusicSearchVC()
        let controller = UISearchController(searchResultsController: resultOfSearchVC)
        controller.searchBar.searchBarStyle = .default
        controller.searchBar.placeholder = "Search Music"
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
   
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigation()
        
        addSubViews()
        applyConstraints()
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Private Methods
    
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
    
    // MARK: - Display Search History Suggestions
    
    private func displaySearchHistorySuggestions(for searchController: UISearchController) {
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        let history = viewModel.getSearchHistory() // Retrieve search history from ViewModel
        searchResultVC.updateSuggestions(history) // Pass the history to MusicSearchVC to display
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate

extension MainVC: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        
        // Если текст пуст, показываем историю поиска
        if text.isEmpty {
            displaySearchHistorySuggestions(for: searchController)
        } else {
            // Обновляем фильтрацию истории
            searchResultVC.searchText = text
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // При начале редактирования показываем историю поиска
        displaySearchHistorySuggestions(for: searchController)
    }
    
    // Обрабатываем нажатие кнопки "Enter" и запускаем поиск
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        
        // Выполняем поиск через ViewModel только при нажатии Enter
        searchResultVC.searchText = searchBar.text ?? ""
        searchResultVC.updateSearchResults()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Если нажали на cancel, очищаем поисковую строку
        guard let searchResultVC = searchController.searchResultsController as? MusicSearchVC else { return }
        searchResultVC.searchText = ""
    }
}
