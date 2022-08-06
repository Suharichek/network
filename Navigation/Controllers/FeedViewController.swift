//
//  FeedViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    private var model = Model()
    private lazy var postButton: CustomButton = {
        let button = CustomButton (
            title: "Перейти на пост",
            titleColor: .black,
            backColor: .systemIndigo,
            backImage: UIImage()
        )
        button.clipsToBounds = false
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowRadius = 5.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        return button
    }()
    
    private lazy var someTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.placeholder = "Введите пароль..."
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    private lazy var someButton: CustomButton = {
        let button = CustomButton (
            title: "Проверить",
            titleColor: .white,
            backColor: .systemIndigo,
            backImage: UIImage()
        )
        return button
    }()
    
    private lazy var someLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        view.backgroundColor = .white
        self.view.addSubview(postButton)
        self.view.addSubview(someLabel)
        self.view.addSubview(someTextField)
        self.view.addSubview(someButton)
        setupFeedLayout()
        
        postButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.showNewPostVC()
        }
        
        someButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.someButtonAction()
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(codeRed),
            name: NSNotification.Name.codeRed,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(codeGreen),
            name: NSNotification.Name.codeGreen,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func codeRed() {
        someLabel.text = "CODE RED"
        someLabel.textColor = .red
    }
    
    @objc func codeGreen() {
        someLabel.text = "CODE GREEN"
        someLabel.textColor = .green
    }
    
    private func someButtonAction() {
        model.check(word: someTextField.text!)
    }
    
    private func setupFeedLayout() {
        postButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        someLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postButton.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        someTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(someLabel.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        someButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(someTextField.snp.bottom).offset(16)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    private func showNewPostVC() {
        let postVC = PostViewController()
        postVC.title = "Новый пост"
        postVC.view.backgroundColor = .systemGray5
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
