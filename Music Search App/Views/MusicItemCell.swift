////
////  MusicItemCell.swift
////  Music Search App
////
////  Created by Bakhtovar on 23/10/24.
////
//
//import Foundation
//import UIKit
//
//class MusicItemCell: UITableViewCell {
//
//    // - MARK: views
//
//    private let wrapper: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 8
//        view.layer.cornerCurve = .continuous
//        view.clipsToBounds = true
//        view.backgroundColor = .white
//        return view
//    }()
//
//    private let musicIcon: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let artistLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.textColor = .black
//        return label
//    }()
//
//    private let trackLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.textColor = .black
//        return label
//    }()
//
//    // - MARK: init
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .clear
//        selectionStyle = .none
//        addSubviews()
//        applyConstraints()
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // - MARK: private
//
//    private func addSubviews() {
//        contentView.addSubview(wrapper)
//        wrapper.addSubview(musicIcon)
//        wrapper.addSubview(artistLabel)
//        wrapper.addSubview(trackLabel)
//    }
//
//    private func applyConstraints() {
//        [
//            wrapper.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            wrapper.leadingAnchor.constraint(equalTo: leadingAnchor),
//            wrapper.trailingAnchor.constraint(equalTo: trailingAnchor),
//            wrapper.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            musicIcon.topAnchor.constraint(equalTo: wrapper.topAnchor),
//            musicIcon.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
//            musicIcon.widthAnchor.constraint(equalToConstant: 80),
//            musicIcon.heightAnchor.constraint(equalToConstant: 80),
//            musicIcon.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
//
//            artistLabel.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 8),
//            artistLabel.leadingAnchor.constraint(equalTo: musicIcon.trailingAnchor, constant: 4),
//            artistLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -16),
//
//            trackLabel.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -8),
//            trackLabel.leadingAnchor.constraint(equalTo: musicIcon.trailingAnchor, constant: 4),
//            trackLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -16)
//
//        ].forEach { $0.isActive = true }
//    }
//
//    // - MARK: public
//
//    public func configure(musicItem: MediaItem) {
//        if let url = URL(string: musicItem.artworkUrl100 ?? "") {
//            ImageLoader.shared.loadImage(url: url) { [weak self] image in
//                DispatchQueue.main.async {
//                    self?.musicIcon.image = image
//                }
//            }
//        }
//        trackLabel.text = musicItem.trackName
//        artistLabel.text = musicItem.artistName
//    }
//}

//
//  MusicItemCell.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import Foundation
import UIKit

//class MusicItemCell: UICollectionViewCell {
//
//    // - MARK: views
//
//    private let wrapper: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.cornerRadius = 8
//        view.layer.cornerCurve = .continuous
//        view.clipsToBounds = true
//        view.backgroundColor = .white
//        return view
//    }()
//
//    private let musicIcon: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let artistLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.textColor = .black
//        return label
//    }()
//
//    private let trackLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.textColor = .black
//        return label
//    }()
//
//    // - MARK: init
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .clear
//        contentView.addSubview(wrapper)
//        wrapper.addSubview(musicIcon)
//        wrapper.addSubview(artistLabel)
//        wrapper.addSubview(trackLabel)
//        applyConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // - MARK: private
//
//    private func applyConstraints() {
//        NSLayoutConstraint.activate([
//            wrapper.topAnchor.constraint(equalTo: contentView.topAnchor),
//            wrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            wrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            wrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
//            musicIcon.topAnchor.constraint(equalTo: wrapper.topAnchor),
//            musicIcon.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor),
//            musicIcon.widthAnchor.constraint(equalToConstant: 80),
//            musicIcon.heightAnchor.constraint(equalToConstant: 80),
//            musicIcon.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
//
//            artistLabel.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 8),
//            artistLabel.leadingAnchor.constraint(equalTo: musicIcon.trailingAnchor, constant: 4),
//            artistLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -16),
//
//            trackLabel.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -8),
//            trackLabel.leadingAnchor.constraint(equalTo: musicIcon.trailingAnchor, constant: 4),
//            trackLabel.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -16)
//        ])
//    }
//
//    // - MARK: public
//
//    public func configure(musicItem: MediaItem) {
//        if let url = URL(string: musicItem.artworkUrl100 ?? "") {
//            ImageLoader.shared.loadImage(url: url) { [weak self] image in
//                DispatchQueue.main.async {
//                    self?.musicIcon.image = image
//                }
//            }
//        }
//        trackLabel.text = musicItem.trackName
//        artistLabel.text = musicItem.artistName
//    }
//}

class MusicItemCell: UICollectionViewCell {
    
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
    
    func configure(with mediaItem: MediaItem) {
        // Загрузка изображения (если доступно)
        if let artworkUrl = mediaItem.artworkUrl100, let url = URL(string: artworkUrl) {
            ImageLoader.shared.loadImage(url: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.mediaIcon.image = image
                }
            }
        } else {
            mediaIcon.image = UIImage(named: "placeholder") // Установить изображение по умолчанию
        }
        
        // Название
        titleLabel.text = mediaItem.trackName
        
        // Тип контента
        switch mediaItem.kind {
        case "movie":
            typeLabel.text = "Movie"
            if let duration = mediaItem.trackTimeMillis {
                let minutes = duration / 60000
                additionalInfoLabel.text = "Duration: \(minutes) min"
            }
        case "audiobook":
            typeLabel.text = "Audiobook"
            if let artistName = mediaItem.artistName {
                additionalInfoLabel.text = "Author: \(artistName)"
            }
            
        case "song":
            typeLabel.text = "Song"
            if let artistName = mediaItem.artistName {
                additionalInfoLabel.text = "Author: \(artistName)"
            }
        default:
            typeLabel.text = mediaItem.kind
            if let artistName = mediaItem.artistName {
                additionalInfoLabel.text = "Author: \(artistName)"
            }
        }
        
        // Цена (если доступна)
        if let price = mediaItem.collectionPrice {
            priceLabel.text = "$\(price)"
        } else {
            priceLabel.text = ""
        }
        
    }
}
