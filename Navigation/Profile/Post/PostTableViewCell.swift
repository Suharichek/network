//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Suharik on 03.04.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    static let identifire = "PostTableViewCell"
    
    private let contentMyView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let postImage: UIImageView = {
        var postImageView = UIImageView()
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .black
        return postImageView
    }()
    
     let postAuthor: UILabel = {
        var postAuthor = UILabel()
        postAuthor.numberOfLines = 2
        postAuthor.font = UIFont.boldSystemFont(ofSize: 20)
        postAuthor.textColor = .black
        postAuthor.translatesAutoresizingMaskIntoConstraints = false
        return postAuthor
    }()
    
    private let postDescription: UITextField = {
        var postDescription = UITextField()
        postDescription.font = .systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        return postDescription
    }()
    
    private let postLikes: UILabel = {
        var postLikes = UILabel()
        postLikes.font = .systemFont(ofSize: 16)
        postLikes.textColor = .black
        postLikes.translatesAutoresizingMaskIntoConstraints = false
        return postLikes
    }()
    
    private let postViews: UILabel = {
        var postViews = UILabel()
        postViews.font = .systemFont(ofSize: 16)
        postViews.textColor = .black
        postViews.translatesAutoresizingMaskIntoConstraints = false
        return postViews
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeCell()
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(lenta: Post){
        postImage.image = lenta.image
        postAuthor.text = lenta.author
        postDescription.text = lenta.description
        postLikes.text = "Likes: " + String(lenta.likes)
        postViews.text = "Views: " + String(lenta.views)
    }
    
    private func customizeCell() {
        contentView.backgroundColor = .systemGray6
    }
    
    private func setupContent(){
        [contentMyView, postAuthor, postImage, postDescription, postLikes, postViews].forEach {contentView.addSubview($0)}
        NSLayoutConstraint.activate([
            contentMyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentMyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentMyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentMyView .bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentMyView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postAuthor.leadingAnchor.constraint(equalTo: contentMyView.leadingAnchor, constant: 16),
            postAuthor.heightAnchor.constraint(equalToConstant: 20),
            
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: contentMyView.leadingAnchor),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescription.leadingAnchor.constraint(equalTo: postImage.trailingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentMyView.trailingAnchor, constant: 16),
            postDescription.heightAnchor.constraint(equalToConstant: 20),
            postDescription.widthAnchor.constraint(equalTo: contentMyView.widthAnchor),
            
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postLikes.leadingAnchor.constraint(equalTo: contentMyView.leadingAnchor, constant: 16),
            postLikes .bottomAnchor.constraint(equalTo: contentMyView.bottomAnchor, constant: -16),
            
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postViews.trailingAnchor.constraint(equalTo: contentMyView.trailingAnchor, constant: -16),
            postViews .bottomAnchor.constraint(equalTo: contentMyView.bottomAnchor, constant: -16)
            
            
        ])
    }
}
