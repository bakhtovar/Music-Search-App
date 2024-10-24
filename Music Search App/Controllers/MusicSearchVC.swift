//
//  MusicSearchVC.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import Foundation
import UIKit

class MusicSearchVC: UIViewController {
    
    // MARK: - properties
    
    var onMediaItemSelected: ((MediaItem) -> Void)?
    
    private var searchResult: [MediaItem] = []
    
    private var searchHistory: [String] = []
    
    private let viewModel = MusicSearchViewModel()
    
    var searchText: String = "" {
        didSet {
            handleSearchTextChange()
        }
    }

    // MARK: - views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MusicItemCell.self, forCellWithReuseIdentifier: MusicItemCell.nameOfCell)
        collectionView.register(RecentSearchCell.self, forCellWithReuseIdentifier: RecentSearchCell.nameOfCell)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var loadIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.textColor = .black
        label.text = "Nothing found"
        label.isHidden = true
        return label
    }()
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.950, green: 0.950, blue: 0.950, alpha: 1)
        addSubviews()
        applyConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        bindViewModel()
    }
    
    // MARK: - private
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(loadIndicator)
        view.addSubview(noResultsLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.didSetMediaResults = { [weak self] mediaResults in
            DispatchQueue.main.async {
                self?.searchResult = mediaResults ?? []
                self?.collectionView.reloadData()
                self?.noResultsLabel.isHidden = self?.searchResult.isEmpty == false
            }
        }
        
        viewModel.didSetSearchInProcess = { [weak self] inProcess in
            DispatchQueue.main.async {
                if inProcess {
                    self?.loadIndicator.startAnimating()
                } else {
                    self?.loadIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.didUpdateSuggestions = { [weak self] suggestions in
            DispatchQueue.main.async {
                self?.searchHistory = suggestions
                if self?.searchResult == nil {
                    self?.collectionView.reloadData()
                }
            }
        }
        
        viewModel.didSetSearchError = { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showErrorMessage(error.message)
                }
            }
        }
    }
    
    private func handleSearchTextChange() {
        noResultsLabel.isHidden = true

        if !searchText.isEmpty {
            viewModel.filterSuggestions(for: searchText)

            // Reload collection view only if there are no search results
            if searchResult.isEmpty {
                collectionView.reloadData()
            }
        } else {
            // If search text is cleared, reset search results and reload history
            searchResult.removeAll()
            collectionView.reloadData()
        }
    }
    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    // MARK: - public
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.viewModel.searchMedia(query: self.searchText)
        }
    }
    
    func updateSuggestions(_ suggestions: [String]) {
        DispatchQueue.main.async {
            self.searchHistory = suggestions
            self.searchResult = []
            self.collectionView.reloadData()
            self.noResultsLabel.isHidden = true
        }
    }
    
    func updateSearchResults() {
        DispatchQueue.main.async {
            self.viewModel.searchMedia(query: self.searchText)
        }
    }
}

// MARK: - extensions

extension MusicSearchVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.isEmpty ? searchHistory.count : searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searchResult.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCell.nameOfCell, for: indexPath) as! RecentSearchCell
            let recentSearchText = searchHistory[indexPath.row]
            cell.configure(text: recentSearchText)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicItemCell.nameOfCell, for: indexPath) as! MusicItemCell
            let item = searchResult[indexPath.row]
            cell.configure(with: item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchResult.isEmpty {
            searchText = searchHistory[indexPath.row]
            updateSearchResults()
        } else {
            let selectedItem = searchResult[indexPath.row]
            onMediaItemSelected?(selectedItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 24) / 2 // Two columns with 8 points of padding
        return CGSize(width: width, height: 90)
    }
}

extension NSObject {
    class var nameOfCell: String {
        return String(describing: self)
    }
}
