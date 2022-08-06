//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Suharik on 04.04.2022.

import UIKit
import SnapKit
import iOSIntPackage

class PhotosTableViewCell: UITableViewCell {
    
    static let identifire = "PhotosTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photosTitle)
        contentView.addSubview(arrowImage)
        contentView.addSubview(photosPreview)
        setupConstraints()
    }
    
    private lazy var photosPreview: PhotosPreview = {
        let photosPreview = PhotosPreview()
        photosPreview.translatesAutoresizingMaskIntoConstraints = false
        photosPreview.setupContent()
        return photosPreview
    }()
    
    private lazy var photosTitle: UILabel = {
        let photosTitle = UILabel()
        photosTitle.translatesAutoresizingMaskIntoConstraints = false
        photosTitle.numberOfLines = 2
        photosTitle.text = "Photos"
        photosTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return photosTitle
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.image = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return arrowImage
    }()
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            photosTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photosTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            arrowImage.centerYAnchor.constraint(equalTo: photosTitle.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 40),
            arrowImage.widthAnchor.constraint(equalToConstant: 40),
            
            photosPreview.topAnchor.constraint(equalTo: photosTitle.bottomAnchor, constant: 8),
            photosPreview.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photosPreview.heightAnchor.constraint(equalToConstant: 70),
            photosPreview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
