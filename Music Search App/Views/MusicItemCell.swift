//
//  MusicItemCell.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import Foundation
import UIKit

class MusicItemCell: UICollectionViewCell {
    
    // MARK: - views
    
    private let wrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let mediaIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    
    private let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .right
        label.textColor = .systemGreen
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .systemYellow
        return label
    }()
    
    // MARK: - override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(wrapper)
        wrapper.addSubview(mediaIcon)
        wrapper.addSubview(titleLabel)
        wrapper.addSubview(typeLabel)
        wrapper.addSubview(additionalInfoLabel)
        wrapper.addSubview(priceLabel)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(equalTo: contentView.topAnchor),
            wrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            mediaIcon.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 8),
            mediaIcon.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 8),
            mediaIcon.widthAnchor.constraint(equalToConstant: 60),
            mediaIcon.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: mediaIcon.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -8),
            
            typeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            typeLabel.leadingAnchor.constraint(equalTo: mediaIcon.trailingAnchor, constant: 8),
            typeLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -8),
            
            additionalInfoLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
            additionalInfoLabel.leadingAnchor.constraint(equalTo: mediaIcon.trailingAnchor, constant: 8),
            additionalInfoLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -2),
            priceLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -4),
            
        ])
    }
    
    // Helper method to format duration in milliseconds to minutes
    private func formatDuration(_ durationInMillis: Int?) -> String {
        guard let duration = durationInMillis else { return "" }
        let minutes = duration / 60000
        return "Duration: \(minutes) min"
    }

    
    // MARK: - public
    
    func configure(with mediaItem: MediaItem) {
        if let artworkUrl = mediaItem.artworkUrl100, let url = URL(string: artworkUrl) {
            ImageLoader.shared.loadImage(url: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.mediaIcon.image = image
                }
            }
        } else {
            mediaIcon.image = nil
        }
        
        // Set title
        titleLabel.text = mediaItem.trackName ?? "Unknown Title"
        
        // Determine the type and additional information
        switch mediaItem.kind {
        case "movie":
            typeLabel.text = "Movie"
            additionalInfoLabel.text = formatDuration(mediaItem.trackTimeMillis)
            
        case "audiobook":
            typeLabel.text = "Audiobook"
            additionalInfoLabel.text = "Author: \(mediaItem.artistName ?? "Unknown Author")"
            
        case "song":
            typeLabel.text = "Song"
            additionalInfoLabel.text = "Artist: \(mediaItem.artistName ?? "Unknown Artist")"
            
        default:
            typeLabel.text = mediaItem.kind ?? "Unknown Type"
            additionalInfoLabel.text = "Artist: \(mediaItem.artistName ?? "Unknown Artist")"
        }
        
        // Set price
        priceLabel.text = mediaItem.collectionPrice.map { "$\($0)" } ?? ""
    }
}
