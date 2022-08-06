//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Suharik on 04.04.2022.
//

import UIKit
import SnapKit
import iOSIntPackage

class PhotosCollectionViewCell: UICollectionViewCell {
    static let identifire = "PhotosCollectionViewCell"
    
    private let photo: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        contentView.clipsToBounds = true
        photo.snp.makeConstraints { make in
            make.height.centerX.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage) {
        self.photo.image = image
    }
}
