//
//  Untitled.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import Foundation
import UIKit

//class MusicSearchVC: UIViewController {
//    
//    // Timer to debounce user input for search
//    private var timer: Timer?
//    
//    // Search result data
//    private var searchResult: [MediaItem] = []
//    
//    // Search history data
//    private var searchHistory: [String] = []
//    
//    // ViewModel for performing the search
//    private let viewModel = MusicSearchViewModel()
//    
//    // Property to hold the current search text
//    var searchText: String = "" {
//        didSet {
//            timer?.invalidate()
//            if searchText.isEmpty {
//                // If the search text is empty, fetch history
//                fetchHistory()
//                searchResult = []
//                tableView.reloadData()
//            } else {
//                // Debounce input and trigger search after a delay
//                timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateSearchResults), userInfo: nil, repeats: false)
//            }
//        }
//    }
//    
//    // Table view to display search results or search history
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .insetGrouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(MusicItemCell.self, forCellReuseIdentifier: MusicItemCell.nameOfCell)
//        tableView.register(RecentSearchCell.self, forCellReuseIdentifier: RecentSearchCell.nameOfCell)
//        tableView.showsVerticalScrollIndicator = false
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = .clear
//        tableView.contentInset = UIEdgeInsets(top: -16, left: 0, bottom: 30, right: 0)
//        return tableView
//    }()
//    
//    private lazy var loadIndicator: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .medium)
//        spinner.color = .black
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        return spinner
//    }()
//    
//    // MARK: - Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 0.950, green: 0.950, blue: 0.950, alpha: 1)
////        view.backgroundColor = .systemBackground
//        addSubviews()
//        applyConstraints()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        // Bind ViewModel changes to update the UI
//        bindViewModel()
//    }
//    
//    // MARK: - Private Methods
//    
//    private func addSubviews() {
//        view.addSubview(tableView)
//        view.addSubview(loadIndicator)
//    }
//    
//    private func applyConstraints() {
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            loadIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//        ])
//    }
//    
//    private func bindViewModel() {
//        // Observe search results from the ViewModel
//        viewModel.didSetMediaResults = { [weak self] mediaResults in
//            DispatchQueue.main.async {
//                self?.searchResult = mediaResults ?? []
//                print("searchResult: \(self?.searchResult)")
//                self?.tableView.reloadData()
//            }
//        }
//          
//        viewModel.didSetSearchInProcess = { inProcess in
//            DispatchQueue.main.async {
//                if inProcess {
//                    self.loadIndicator.startAnimating()
//                } else {
//                    self.loadIndicator.stopAnimating()
//                }
//            }
//        }
//        
//        // Observe errors from the ViewModel
//        viewModel.didSetSearchError = { [weak self] error in
//            if let error = error {
//                self?.showErrorMessage(error.message)
//            }
//        }
//    }
//    
//    @objc private func updateSearchResults() {
//        // Perform search using the ViewModel
//        viewModel.searchMedia(query: searchText)
//    }
//    
//    private func fetchHistory() {
//        // Get search history from ViewModel
//        searchHistory = viewModel.getSearchHistory()
//        tableView.reloadData()
//    }
//    
//    // Show error messages (simple implementation)
//    private func showErrorMessage(_ message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true)
//    }
//    
//    // To handle history suggestions
//    func updateSuggestions(_ suggestions: [String]) {
//        self.searchHistory = suggestions
//        self.searchResult = []
//        tableView.reloadData() // Reload table view with suggestions
//    }
//}
//
//// MARK: - UITableViewDataSource, UITableViewDelegate
//
//extension MusicSearchVC: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return searchText.isEmpty ? searchHistory.count : searchResult.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if searchText.isEmpty {
//            // Show recent search history when search text is empty
//            let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchCell.nameOfCell, for: indexPath) as! RecentSearchCell
//            let recentSearchText = searchHistory[indexPath.section]
//            cell.configure(text: recentSearchText)
//            return cell
//        } else {
//            // Show music search results when search text is not empty
//            let cell = tableView.dequeueReusableCell(withIdentifier: MusicItemCell.nameOfCell, for: indexPath) as! MusicItemCell
//            let item = searchResult[indexPath.section]
//            cell.configure(musicItem: item)
//            return cell
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Handle selection of history or search result
//        if searchText.isEmpty {
//            // Use history item as new search text
//            searchText = searchHistory[indexPath.section]
//        } else {
//            // Open detailed view for selected media item
//            let selectedItem = searchResult[indexPath.section]
//            openDetailView(with: selectedItem)
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if searchText.isEmpty {
//            return 30 // Height for RecentSearchCell
//        } else {
//            return 88 // Height for MusicItemCell
//        }
//    }
//    
//    private func openDetailView(with item: MediaItem) {
//        print("OPEN DETAIL VIEW") // TODO:
////        // Push a detail view controller showing the media item details
////        let detailVC = MediaDetailViewController(mediaItem: item)
////        navigationController?.pushViewController(detailVC, animated: true)
//    }
//}
//
//extension NSObject {
//    
//    class var nameOfCell: String {
//        return String(describing: self)
//    }
//}

//class MusicSearchVC: UIViewController {
//    
//    // Timer to debounce user input for search
//    private var timer: Timer?
//    
//    // Search result data
//    private var searchResult: [MediaItem] = []
//    
//    // Search history suggestions
//    private var searchHistory: [String] = []
//    
//    // ViewModel for performing the search
//    private let viewModel = MusicSearchViewModel()
//    
//    // Property to hold the current search text
//    var searchText: String = "" {
//        didSet {
//            timer?.invalidate()
//            if searchText.isEmpty {
//                // If the search text is empty, fetch history suggestions
//                fetchHistory()
//                searchResult = []
//                collectionView.reloadData()
//            } else {
//                // Filter history suggestions based on the input
//                viewModel.filterSuggestions(for: searchText)
//                // Debounce input and trigger search after a delay
//                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSearchResults), userInfo: nil, repeats: false)
//            }
//        }
//    }
//    
//    // Collection view to display search results or search history
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 8
//        layout.minimumLineSpacing = 8
//        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(MusicItemCell.self, forCellWithReuseIdentifier: MusicItemCell.nameOfCell)
//        collectionView.register(RecentSearchCell.self, forCellWithReuseIdentifier: RecentSearchCell.nameOfCell)
//        collectionView.backgroundColor = .clear
//        return collectionView
//    }()
//    
//    private lazy var loadIndicator: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .medium)
//        spinner.color = .black
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        return spinner
//    }()
//    
//    // MARK: - Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 0.950, green: 0.950, blue: 0.950, alpha: 1)
//        addSubviews()
//        applyConstraints()
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        
//        // Bind ViewModel changes to update the UI
//        bindViewModel()
//    }
//    
//    // MARK: - Private Methods
//    
//    private func addSubviews() {
//        view.addSubview(collectionView)
//        view.addSubview(loadIndicator)
//    }
//    
//    private func applyConstraints() {
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            loadIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//        ])
//    }
//    
//    private func bindViewModel() {
//        // Observe search results from the ViewModel
//        viewModel.didSetMediaResults = { [weak self] mediaResults in
//            DispatchQueue.main.async {
//                self?.searchResult = mediaResults ?? []
//                self?.collectionView.reloadData()
//            }
//        }
//        
//        // Observe loading state (show or hide spinner)
//        viewModel.didSetSearchInProcess = { [weak self] inProcess in
//            DispatchQueue.main.async {
//                if inProcess {
//                    self?.loadIndicator.startAnimating()
//                } else {
//                    self?.loadIndicator.stopAnimating()
//                }
//            }
//        }
//        
//        // Observe filtered suggestions from the ViewModel
//        viewModel.didUpdateSuggestions = { [weak self] suggestions in
//            DispatchQueue.main.async {
//                self?.searchHistory = suggestions
//                self?.collectionView.reloadData()
//            }
//        }
//        
//        // Observe errors from the ViewModel
//        viewModel.didSetSearchError = { [weak self] error in
//            if let error = error {
//                self?.showErrorMessage(error.message)
//            }
//        }
//    }
//    
//    @objc private func updateSearchResults() {
//        // Perform search using the ViewModel
////        viewModel.searchMedia(query: searchText)
//        DispatchQueue.main.async { // Ensure UI updates happen on the main thread
//            self.viewModel.searchMedia(query: self.searchText)
//        }
//    }
//    
//    private func fetchHistory() {
//        // Get search history from ViewModel
//        searchHistory = viewModel.getSearchHistory()
//        collectionView.reloadData()
//    }
//    
//    // Show error messages (simple implementation)
//    private func showErrorMessage(_ message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true)
//    }
//    
//    // To handle history suggestions
//    func updateSuggestions(_ suggestions: [String]) {
//        DispatchQueue.main.async {
//            self.searchHistory = suggestions
//            self.searchResult = []
//            self.collectionView.reloadData()
//        }
//    }
//}
//
// // MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
//
//extension MusicSearchVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return searchText.isEmpty ? searchHistory.count : searchResult.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if searchText.isEmpty {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCell.nameOfCell, for: indexPath) as! RecentSearchCell
//            let recentSearchText = searchHistory[indexPath.row]
//            cell.configure(text: recentSearchText)
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicItemCell.nameOfCell, for: indexPath) as! MusicItemCell
//            let item = searchResult[indexPath.row]
//            cell.configure(musicItem: item)
//            return cell
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if searchText.isEmpty {
//            searchText = searchHistory[indexPath.row]
//        } else {
//            let selectedItem = searchResult[indexPath.row]
//            openDetailView(with: selectedItem)
//        }
//    }
//    
//    // MARK: - UICollectionViewDelegateFlowLayout
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.bounds.width - 24) / 2 // Two columns with 8 points of padding
//        return CGSize(width: width, height: 90)
//    }
//    
//    private func openDetailView(with item: MediaItem) {
//        print("OPEN DETAIL VIEW") // TODO: Implement the detail view for the selected media item
//    }
//}
//
//extension NSObject {
//    class var nameOfCell: String {
//        return String(describing: self)
//    }
//}

class MusicSearchVC: UIViewController {
    
    var onMediaItemSelected: ((MediaItem) -> Void)?
    
    // Timer to debounce user input for search
    private var timer: Timer?
    
    // Search result data
    private var searchResult: [MediaItem] = []
    
    // Search history suggestions
    private var searchHistory: [String] = []
    
    // ViewModel for performing the search
    private let viewModel = MusicSearchViewModel()
    
    // Property to hold the current search text
    var searchText: String = "" {
        didSet {
            // Здесь просто фильтруем историю поиска при каждом изменении текста
            viewModel.filterSuggestions(for: searchText)
            if self.searchResult.isEmpty == true {
                collectionView.reloadData()
            }
        }
    }
    
    // Collection view to display search results or search history
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.950, green: 0.950, blue: 0.950, alpha: 1)
        addSubviews()
        applyConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Bind ViewModel changes to update the UI
        bindViewModel()
        
        addKeyboardObservers()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(loadIndicator)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        ])
    }
    
    private func bindViewModel() {
        // Observe search results from the ViewModel
        viewModel.didSetMediaResults = { [weak self] mediaResults in
            DispatchQueue.main.async {
                self?.searchResult = mediaResults ?? []
                self?.collectionView.reloadData()
            }
        }
        
        // Observe loading state (show or hide spinner)
        viewModel.didSetSearchInProcess = { [weak self] inProcess in
            DispatchQueue.main.async {
                if inProcess {
                    self?.loadIndicator.startAnimating()
                } else {
                    self?.loadIndicator.stopAnimating()
                }
            }
        }
        
        // Observe filtered suggestions from the ViewModel
        viewModel.didUpdateSuggestions = { [weak self] suggestions in
            DispatchQueue.main.async {
                self?.searchHistory = suggestions
                if self?.searchResult == nil {
                    self?.collectionView.reloadData()
                }
            }
        }
        
        // Observe errors from the ViewModel
        viewModel.didSetSearchError = { [weak self] error in
            if let error = error {
                self?.showErrorMessage(error.message)
            }
        }
    }
    
    // Выполнение поиска при нажатии "Enter"
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Вызов метода для поиска
        DispatchQueue.main.async {
            self.viewModel.searchMedia(query: self.searchText)
        }
    }
    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func updateSuggestions(_ suggestions: [String]) {
        DispatchQueue.main.async {
            self.searchHistory = suggestions
            self.searchResult = []
            self.collectionView.reloadData()
        }
    }
    
    func updateSearchResults() {
        DispatchQueue.main.async {
            self.viewModel.searchMedia(query: self.searchText)
        }
    }
}

 // MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension MusicSearchVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return searchText.isEmpty ? searchHistory.count : searchResult.count
        return searchResult.isEmpty ? searchHistory.count : searchResult.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if searchText.isEmpty {
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
        // if searchText.isEmpty {
        if searchResult.isEmpty {
            searchText = searchHistory[indexPath.row]
            updateSearchResults()
        } else {
            let selectedItem = searchResult[indexPath.row]
            onMediaItemSelected?(selectedItem)
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 24) / 2 // Two columns with 8 points of padding
        return CGSize(width: width, height: 90)
    }
    
    
    // MARK: - objc
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue {
            self.collectionView.contentInset = UIEdgeInsets(
                top: 8,
                left: 0,
                bottom: keyboardSize.height,
                right: 0
            )
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
    }
}

extension NSObject {
    class var nameOfCell: String {
        return String(describing: self)
    }
}

extension MusicSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textUpdate: \(searchText)")
        self.searchText = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = ""
        collectionView.reloadData()
    }
}
