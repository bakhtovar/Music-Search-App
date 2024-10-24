//
//  AboutMediaVC.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import UIKit

class AboutMediaVC: UIViewController {
    
    // MARK: - Properties
    
    private var mediaItem: MediaItem
    private var artistDetails: ArtistDetails?
    private let viewModel = MusicSearchViewModel()
    
    
    // MARK: - init
    
    init(mediaItem: MediaItem) {
        self.mediaItem = mediaItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - views
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let contentTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let contentLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View Content", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let authorLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("More about the Author", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private lazy var loadIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        applyConstraints()
        
        if let artistId = mediaItem.artistId {
            viewModel.lookupArtist(artistId: artistId)
        }
        
        configureMediaDetails()
        bindViewModel()
        
        contentLinkButton.addTarget(self, action: #selector(didTapContentLink), for: .touchUpInside)
        authorLinkButton.addTarget(self, action: #selector(didTapAuthorLink), for: .touchUpInside)
    }
    
    // MARK: - private
    
    private func addSubviews() {
        view.addSubview(contentImageView)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(contentTypeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(additionalInfoLabel)
        view.addSubview(contentLinkButton)
        view.addSubview(authorLinkButton)
        view.addSubview(loadIndicator)
    }
    
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: contentImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            contentTypeLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            contentTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentTypeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            additionalInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            additionalInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentLinkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            contentLinkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            contentLinkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            contentLinkButton.heightAnchor.constraint(equalToConstant: 40),
            
            authorLinkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            authorLinkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            authorLinkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            authorLinkButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func bindViewModel() {
        viewModel.didSetArtistDetails = { [weak self] artistDetails in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateArtistDetails(artistDetails)
            }
        }
        
        viewModel.didSetArtistLookupInProgress = { [weak self] inProgress in
            DispatchQueue.main.async {
                if inProgress {
                    self?.loadIndicator.startAnimating()
                } else {
                    self?.loadIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.didSetArtistLookupError = { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showErrorMessage(error.message)
                }
            }
        }
    }
    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func configureMediaDetails() {
        
        titleLabel.text = "Track: \(mediaItem.trackName ?? "N/A")"
        authorLabel.text = "Author: \(mediaItem.artistName ?? "Unknown")"
        contentTypeLabel.text = "Type: \(mediaItem.wrapperType ?? mediaItem.kind ?? "Unknown")"
        descriptionLabel.text = "Description: \(mediaItem.collectionName ?? "No description available")"
        
        // Load the image if available
        if let imageUrlString = mediaItem.artworkUrl100, let imageUrl = URL(string: imageUrlString) {
            ImageLoader.shared.loadImage(url: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.contentImageView.image = image
                }
            }
        }
        
        contentLinkButton.isHidden = (mediaItem.trackViewUrl == nil)
    }
    
    private func updateArtistDetails(_ artistDetails: ArtistDetails?) {
        guard let artistDetails = artistDetails else { return }
        
        self.artistDetails = artistDetails
        additionalInfoLabel.text = """
          Artist: \(artistDetails.artistName)
          Genre: \(artistDetails.primaryGenreName ?? "Unknown")
          """
        
        authorLinkButton.isHidden = (artistDetails.artistLinkUrl == nil)
    }
    
    // MARK: - objc
    
    @objc private func didTapContentLink() {
        guard let urlString = mediaItem.trackViewUrl, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func didTapAuthorLink() {
        guard let urlString = artistDetails?.artistLinkUrl, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
