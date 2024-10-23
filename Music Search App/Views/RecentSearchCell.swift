////
////  RecentSearchCell.swift
////  Music Search App
////
////  Created by Bakhtovar on 23/10/24.
////
//
//import Foundation
//import UIKit
//
//class RecentSearchCell: UITableViewCell {
//    
//    var didSelect: ((Int) -> Void)? = nil
//    
//    // - MARK: views
//    
//    private let clockImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "clock")
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.tintColor = .black
//        return imageView
//    }()
//    
//    private let searchQueryLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .black
//        label.lineBreakMode = .byWordWrapping
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        return label
//    }()
//    
//    private let separatorLine: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .lightGray
//        return view
//    }()
//   
//    // - MARK: override
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        selectionStyle = .none
//        backgroundColor = .clear
//        
//        addSubviews()
//        applyConstraints()
//        
////        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapWrapper))
////        wrapper.addGestureRecognizer(tapGestureRecognizer)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // - MARK: public
//  
//    public func configure(text: String) {
//        searchQueryLabel.text = text
//    }
//    
//    // - MARK: private
//    
//    private func addSubviews() {
//        contentView.addSubview(clockImageView)
//        contentView.addSubview(searchQueryLabel)
//        contentView.addSubview(separatorLine)
//    }
//    
//    private func applyConstraints() {
//        [
//            clockImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            clockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            clockImageView.widthAnchor.constraint(equalToConstant: 25),
//            clockImageView.heightAnchor.constraint(equalToConstant: 25),
//            
//            searchQueryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            searchQueryLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 4),
//            
//            separatorLine.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0.5),
//            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
//           
//        ].forEach { $0?.isActive = true }
//    }
//
//    // - MARK: objc
//    
////    @objc private func didTapWrapper() {
////        didSelect?(id)
////    }
//}


//
//  RecentSearchCell.swift
//  Music Search App
//
//  Created by Bakhtovar on 23/10/24.
//

import Foundation
import UIKit

class RecentSearchCell: UICollectionViewCell {
    
    var didSelect: ((Int) -> Void)? = nil
    
    // - MARK: views
    
    private let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "clock")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        return imageView
    }()
    
    private let searchQueryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
   
    // - MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(clockImageView)
        contentView.addSubview(searchQueryLabel)
        contentView.addSubview(separatorLine)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // - MARK: public
  
    public func configure(text: String) {
        searchQueryLabel.text = text
    }
    
    // - MARK: private
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            clockImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            clockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            clockImageView.widthAnchor.constraint(equalToConstant: 25),
            clockImageView.heightAnchor.constraint(equalToConstant: 25),
            
            searchQueryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            searchQueryLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: 4),
            
            separatorLine.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0.5),
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
