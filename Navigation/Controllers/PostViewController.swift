//
//  PostViewController.swift
//  Navigation
//
//  Created by Suharik on 11.03.2022.
//

import UIKit
import SnapKit

enum AppConfiguration: String {
    case one =  "https://swapi.dev/api/films/"
    case two = "https://swapi.dev/api/people/"
    case three = "https://swapi.dev/api/vehicles/"
}
class PostViewController: UIViewController {
    
    struct NetworkService {
        
    }

    private lazy var urlTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.placeholder = "Шутка"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    private lazy var jokeButton: CustomButton = {
        let button = CustomButton (
            title: "Ссылка",
            titleColor: .white,
            backColor: .systemIndigo,
            backImage: UIImage()
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        let button = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(openInfo))
        navigationItem.rightBarButtonItem = button
        self.view.addSubview(urlTextField)
        self.view.addSubview(jokeButton)
        setupFeedLayout()
        
        jokeButton.tapAction = { [weak self] in
            guard self != nil else { return }
            PostViewController.request(for: .one)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func openInfo(){
        let rootVC = InfoViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        present(navVC, animated: true)
    }
    
    static func request(for configuration: AppConfiguration) {
        switch configuration {
        case .one:
            let firstURL = URL(string: AppConfiguration.one.rawValue)!
            let session = URLSession.shared
            let task = session.dataTask(with: firstURL) {
                data, response, error in
                print("data: \(String(decoding: data!, as: UTF8.self))")
                if let httpResponse = response as? HTTPURLResponse {
                    print("headerFields: \(httpResponse.allHeaderFields)")
                    print("statusCode: \(httpResponse.statusCode)")
                }
                print("localized: \(error?.localizedDescription)")
                print("debug: \(error.debugDescription)")
            }
            task.resume()
        case .two:
            let secondURL = URL(string: AppConfiguration.two.rawValue)!
            let session = URLSession.shared
            let task = session.dataTask(with: secondURL) {
                data, response, error in
                print("data: \(String(decoding: data!, as: UTF8.self))")
                if let httpResponse = response as? HTTPURLResponse {
                    print("headerFields: \(httpResponse.allHeaderFields)")
                    print("statusCode: \(httpResponse.statusCode)")
                }
                print("localized: \(error?.localizedDescription)")
                print("debug: \(error.debugDescription)")
            }
            task.resume()
        case .three:
            let thirdURL = URL(string: AppConfiguration.three.rawValue)!
            let session = URLSession.shared
            let task = session.dataTask(with: thirdURL) {
                data, response, error in
                print("data: \(String(decoding: data!, as: UTF8.self))")
                if let httpResponse = response as? HTTPURLResponse {
                    print("headerFields: \(httpResponse.allHeaderFields)")
                    print("statusCode: \(httpResponse.statusCode)")
                }
                print("localized: \(error?.localizedDescription)")
                print("debug: \(error.debugDescription)")
            }
            task.resume()
        }
    }
    
    private func setupFeedLayout() {
        urlTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(200)
        }
        
        jokeButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalTo(urlTextField.snp.bottom).offset(16)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    class InfoViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = "Информация"
            view.addSubview(buttonAlert)
            setupButton()
            buttonAlert.tapAction = { [weak self] in
                guard let self = self else { return }
                self.showAlertButtonTapped()
            }
        }
        @IBAction func showAlertButtonTapped() {
            let alert = UIAlertController(title: "ВнИмАнИе", message: "Шо то идет не так...", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Понято", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Непонято", style: UIAlertAction.Style.destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "Выйти", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        private lazy var buttonAlert: CustomButton = {
            let button = CustomButton (
                title: "Открыть предупреждение",
                titleColor: .black,
                backColor: .systemIndigo,
                backImage: UIImage()
            )
            return button
        }()
        
        @objc private func buttonAction() {
            showAlertButtonTapped()
        }
        
        func setupButton(){
            buttonAlert.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
            }
        }
    }
}
