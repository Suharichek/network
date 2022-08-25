//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit
import StorageService
import SnapKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    let photosViewController = PhotosViewController()
    let profileHeaderView = ProfileHeaderView()
    let posts = Post.createPosts()
    var userService: UserService
    var fullName: String
    
    init (userService: UserService, name: String) {
        self.userService = userService
        self.fullName = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        var myTableView = UITableView()
        myTableView.backgroundColor = .white
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        return myTableView
    } ()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Мой профиль"
        self.profileHeaderView.backgroundColor = .systemGray6
        view.backgroundColor = .systemGray6
        profileHeaderView.statusTextField.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        profileHeaderView.setupViews()
        self.view.addSubview(tableView)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifire)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupLayout()
        profileHeaderView.setStatusButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.profileHeaderView.setStatusbuttonPressed()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupLayout(){
        view.addSubview(profileHeaderView)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        profileHeaderView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(220)
        }
    }
    
    func showPhotosVC() {
        photosViewController.title = "Photo Gallery"
        photosViewController.view.backgroundColor = .white
        self.navigationController?.pushViewController(photosViewController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return posts.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifire, for: indexPath) as! PhotosTableViewCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.setupCell(lenta: posts[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = UIView()
        view = profileHeaderView
        let currentUser = userService.userIdentify(name: fullName)
        profileHeaderView.fullNameLabel.text = currentUser?.fullName
        profileHeaderView.avatarImageView.image = currentUser?.avatar
        profileHeaderView.statusLabel.text = currentUser?.status
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 220
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 0 else {return}
        showPhotosVC()
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
